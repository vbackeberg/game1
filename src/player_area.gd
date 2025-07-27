extends Node2D

const CARD_WIDTH = 128.0
var playerName: String
var resourcesOnHand: Array[Node]
var resourceCapacity: int
var additionalResources: Array[int]
var charactersOnPayField: Array[Node]
var diamonds: Array[Node]
var selectedResources: Array[Node]
var selectedDiamonds: Array[Node]
var charactersPlayed: Array[Node]
var actionsLeft: int
var actionsPerTurn: int
var discardMode: bool
var numToDiscard: int

var victoryPoints: int

signal action_used()
signal discard_started()
signal discard_finished()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerName = str(randi() % 100 + 1)
	resourcesOnHand = []
	resourceCapacity = 5
	additionalResources = []
	charactersOnPayField = []
	diamonds = []
	selectedResources = []
	selectedDiamonds = []
	charactersPlayed = []
	visible = false
	actionsLeft = actionsPerTurn
	actionsPerTurn = 3
	victoryPoints = 0

	discardMode = false
	numToDiscard = 0
	$ConfirmDiscardButton.visible = false
	discard_started.connect(get_parent().on_discard_started.bind())
	discard_finished.connect(get_parent().on_discard_finished.bind())

## Appends and prints card
func add_resource(value: int):
	var card_node = load("res://src/card_resource.tscn").instantiate() as TextureButton
	card_node.custom_minimum_size = Vector2(CARD_WIDTH, 200.0)
	card_node.texture_normal = load("res://assets/resource" + str(value) + ".png")
	card_node.value = value
	card_node.visible = visible # Match parent's visibility
	resourcesOnHand.append(card_node)
	add_child(card_node)
	
	var card_index = resourcesOnHand.size() - 1
	card_node.position.x = 24.0 + card_index * (CARD_WIDTH + 24.0)
	card_node.position.y = get_viewport().size.y / 2
	
	card_node.pressed.connect(_on_resource_card_pressed.bind(card_node))

func discard_if_too_many_cards():
	var excess = resourcesOnHand.size() - resourceCapacity
	if excess > 0:
		discard_started.emit()
		discardMode = true
		numToDiscard = excess
		selectedResources.clear()
		print("You have " + str(numToDiscard) + " cards to discard.")
	else:
		discard_finished.emit()

## Selects or deselects a resource on press
func _on_resource_card_pressed(card: TextureButton) -> void:
	var index = selectedResources.find(card)
	if discardMode:
		if index == -1:
			if selectedResources.size() == numToDiscard:
				return

			card.modulate = Color(1.2, 0.8, 0.8) # Red tint for discard
			selectedResources.append(card)
		else:
			selectedResources.remove_at(index)
			card.modulate = Color(1, 1, 1) # Reset to normal color
		
		if selectedResources.size() == numToDiscard:
			$ConfirmDiscardButton.visible = true
		else:
			$ConfirmDiscardButton.visible = false

	else:
		if index == -1:
			selectedResources.append(card)
			card.modulate = Color(1.2, 1.2, 0.8) # Yellow tint
		else:
			selectedResources.remove_at(index)
			card.modulate = Color(1, 1, 1) # Reset to normal color

func _on_confirm_discard_button_pressed() -> void:
	for r in selectedResources:
		get_parent().on_resource_spent(r.value)
		resourcesOnHand.erase(r)
		r.queue_free()
		numToDiscard -= 1
		if numToDiscard == 0:
			$ConfirmDiscardButton.visible = false
			discardMode = false
			_reorder_resource_cards()
			discard_finished.emit()

## Adds a character card with given specs and puts it on the right side.
func add_character(specs):
	if charactersOnPayField.size() == 2:
		# TODO prevent player from doing that
		print("Player has 2 character cards, already.")
	
	else:
		var card_node = load("res://src/card_character.tscn").instantiate() as TextureButton
		card_node.custom_minimum_size = Vector2(CARD_WIDTH, 200.0)
		card_node.texture_normal = load("res://assets/character-" + str(concat(specs.cost)) + "-" + str(specs.diamondCost) + "-" + str(specs.points) + "-" + str(specs.diamonds) + ".png")
		card_node.specs = specs
		card_node.visible = visible
		charactersOnPayField.append(card_node)
		add_child(card_node)

		var card_index = charactersOnPayField.size()
		card_node.position.x = get_viewport().size.x - 24.0 - card_index * (CARD_WIDTH + 24.0)
		card_node.position.y = get_viewport().size.y / 2
		
		card_node.pressed.connect(_on_character_card_pressed.bind(card_node))

func _on_character_card_pressed(card: TextureButton) -> void:
	if _diamondCostPaid(card) && _resourceCostPaid(card):
		_play_character(card)
	else:
		print("Not enough resources/diamonds selected to play character!")


func _diamondCostPaid(card):
	print(selectedDiamonds.size(), " diamonds selected. ", card.specs.diamondCost, " needed.")
	return selectedDiamonds.size() >= card.specs.diamondCost

func _resourceCostPaid(card):
	var remainingResourceCost = card.specs.cost.duplicate()
	
	for r in selectedResources:
		var index = remainingResourceCost.find(r.value)
		if index != -1:
			remainingResourceCost.remove_at(index)

	print("Remaining resource cost: ", remainingResourceCost)

	return remainingResourceCost.size() == 0

## Loads and positions diamond card asset. Connects on_pressed callback.
## Note: Character values are associated with the diamond to identify the card later in the graveyard.
func add_diamond(card: Dictionary):
	var cardDiamond = load("res://src/card_character.tscn").instantiate() as TextureButton
	cardDiamond.custom_minimum_size = Vector2(CARD_WIDTH, 200.0)
	cardDiamond.texture_normal = load("res://assets/character_back.png")
	cardDiamond.specs = card
	cardDiamond.visible = visible
	diamonds.append(cardDiamond)
	add_child(cardDiamond)

	var card_index = diamonds.size()
	cardDiamond.position.x = get_viewport().size.x - 24.0 - card_index * (CARD_WIDTH + 24.0)
	cardDiamond.position.y = 24.0 
	
	cardDiamond.pressed.connect(_on_diamond_card_pressed.bind(cardDiamond))


func _on_diamond_card_pressed(card: TextureButton) -> void:
	var index = selectedDiamonds.find(card)

	if index == -1:
		selectedDiamonds.append(card)
		card.modulate = Color(1.2, 1.2, 0.8) # Yellow tint
	else:
		selectedDiamonds.remove_at(index)
		card.modulate = Color(1, 1, 1) # Reset to normal color


## Puts spent resources and diamonds on graveyard
## Places character card
func _play_character(card: TextureButton):
	charactersPlayed.append(card)
	var card_index = charactersPlayed.size()
	card.position.x = 24.0 + card_index * (CARD_WIDTH + 24.0)
	card.position.y = 24.0 + 200.0
	card.rotation_degrees = 180
	
	charactersOnPayField.erase(card)

	# TODO pass to-be-paid resources and diamonds to this function. Safer and simpler.
	var remainingDiamondCost = card.specs.diamondCost
	while remainingDiamondCost > 0:
		remainingDiamondCost -= 1
		var d = selectedDiamonds.pop_back()
		get_parent().on_diamond_spent(d.specs)
		diamonds.erase(d)
		d.queue_free()

	selectedDiamonds.clear()
	_reorder_diamonds()

	var remainingResourceCost = card.specs.cost.duplicate()
	for r in selectedResources:
		var index = remainingResourceCost.find(r.value)
		if index != -1:
			remainingResourceCost.remove_at(index)
			get_parent().on_resource_spent(r.value)
			resourcesOnHand.erase(r)
			r.queue_free()
	
	selectedResources.clear()
	_reorder_resource_cards()

	action_used.emit()

	victoryPoints += card.specs.points
	get_parent().middleArea.draw_diamond()

func _reorder_diamonds():
	for i in range(diamonds.size()):
		diamonds[i].position.x = get_viewport().size.x - 24.0 - i * (CARD_WIDTH + 24.0)
	
func _reorder_resource_cards():
	for i in range(resourcesOnHand.size()):
		resourcesOnHand[i].position.x = 24.0 + i * (CARD_WIDTH + 24.0)


func _on_visibility_changed() -> void:
	for card in resourcesOnHand:
		card.visible = visible
	
	for card in charactersOnPayField:
		card.visible = visible

	for card in diamonds:
		card.visible = visible
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func concat(arr: Array) -> String:
	var result = ""
	for num in arr:
		result += str(num)
	return result
