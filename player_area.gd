extends Node2D

const CARD_WIDTH = 128.0
var resourcesOnHand: Array[Node]
var charactersOnPayField: Array[Node]
var selectedResources: Array[Node]
var charactersPlayed: Array[Node]

signal action_used()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resourcesOnHand = []
	charactersOnPayField = []
	selectedResources = []
	charactersPlayed = []
	visible = false

## Appends and prints card
func add_resource(value: int):
	var card_node = load("res://card_resource.tscn").instantiate() as TextureButton
	card_node.custom_minimum_size = Vector2(CARD_WIDTH, 200.0)
	card_node.texture_normal = load("res://assets/resource" + str(value) + ".png")
	card_node.value = value
	card_node.visible = visible # Match parent's visibility
	resourcesOnHand.append(card_node)
	add_child(card_node)
	
	var card_index = resourcesOnHand.size() - 1
	card_node.position.x = 24.0 + card_index * (CARD_WIDTH + 24.0)
	card_node.position.y = get_viewport().size.y / 2
	
	card_node.pressed.connect(_on_resource_card_selected.bind(card_node))

## Selects or deselects a resource on press
func _on_resource_card_selected(card: TextureButton) -> void:
	var index = selectedResources.find(card)
	
	if index == -1:
		selectedResources.append(card)
		card.modulate = Color(1.2, 1.2, 0.8) # Yellow tint
	else:
		selectedResources.remove_at(index)
		card.modulate = Color(1, 1, 1) # Reset to normal color

## Adds a character card with given specs and puts it on the right side.
func add_character(cost, diamondCost, points, diamonds):
	if charactersOnPayField.size() == 2:
		print("Player has 2 character cards, already.")
	
	else:
		var card_node = load("res://card_character.tscn").instantiate() as TextureButton
		card_node.custom_minimum_size = Vector2(CARD_WIDTH, 200.0)
		card_node.texture_normal = load("res://assets/character-" + str(concat(cost)) + "-" + str(diamondCost) + "-" + str(points) + "-" + str(diamonds) + ".png")
		card_node.cost = cost
		card_node.diamondCost = diamondCost
		card_node.points = points
		card_node.diamonds = diamonds
		card_node.visible = visible
		charactersOnPayField.append(card_node)
		add_child(card_node)

		var card_index = charactersOnPayField.size()
		card_node.position.x = get_viewport().size.x - 24.0 - card_index * (CARD_WIDTH + 24.0)
		card_node.position.y = get_viewport().size.y / 2
		
		card_node.pressed.connect(_on_character_card_pressed.bind(card_node))

func _on_character_card_pressed(card: TextureButton) -> void:
	var selectedValues = []
	for r in selectedResources:
		selectedValues.append(r.value)
	
	var remainingCost = card.cost.duplicate()
	
	for value in selectedValues:
		var index = remainingCost.find(value)
		if index != -1:
			remainingCost.remove_at(index)
	
	if remainingCost.size() == 0:
		playCharacter(card)
	else:
		print("Cannot play character card! Missing resources: ", remainingCost)


## Move card to top left and rotate it.
## Remove character from pay field and add to played characters.
## Remove used resources.
## Reposition remaining resources.
func playCharacter(character: TextureButton):
	charactersPlayed.append(character)
	var card_index = charactersPlayed.size()
	character.position.x = 24.0 + card_index * (CARD_WIDTH + 24.0)
	character.position.y = 24.0 + 200.0
	character.rotation_degrees = 180
	
	charactersOnPayField.erase(character)
	
	for r in selectedResources:
		get_parent().middleArea.graveyardResources.append(r.value)
		resourcesOnHand.erase(r)
		r.queue_free()
	
	selectedResources.clear()
	
	for i in range(resourcesOnHand.size()):
		resourcesOnHand[i].position.x = 24.0 + i * (CARD_WIDTH + 24.0)

	action_used.emit()
	
	var totalPoints = charactersPlayed.reduce(func(acc, card): return acc + card.points, 0)
	if totalPoints > 11:
		print("Player has " + totalPoints + " points. Last round!")
	

func _on_visibility_changed() -> void:
	for card in resourcesOnHand:
		card.visible = visible
	
	for card in charactersOnPayField:
		card.visible = visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func concat(arr: Array) -> String:
	var result = ""
	for num in arr:
		result += str(num)
	return result
