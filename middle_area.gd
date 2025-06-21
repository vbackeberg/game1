extends Node2D

const CARD_WIDTH = 128.0

var resourceCards: Array[int]
var characterCards: Array[Dictionary]
var cardsLaidOut: Array[TextureButton]

@export var graveyardResources: Array[int]
@export var graveyardCharacters: Array[Dictionary]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resourceCards = [1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8]
	resourceCards.shuffle()
	
	characterCards = [
		{
			cost = [6,6],
			diamondCost = 0,
			points = 1,
			diamonds = 0			
		},
		{
			cost = [7,7],
			diamondCost = 0,
			points = 1,
			diamonds = 0			
		},
		{
			cost = [2,2,2],
			diamondCost = 1,
			points = 3,
			diamonds = 0			
		},
		{
			cost = [6,6,8,8],
			diamondCost = 0,
			points = 3,
			diamonds = 0			
		},
	]
	characterCards.shuffle()
	
	graveyardResources = []
	graveyardCharacters = []
	cardsLaidOut = []
	cardsLaidOut.resize(4)

	place_resource(0)
	place_resource(1)
	place_resource(2)	
	place_resource(3)
	
	place_character(0)
	place_character(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _draw_resource() -> int:
	if resourceCards.size() == 0:
		if graveyardResources.size() == 0:
			print("No more resource cards left in stack or graveyard!")
		else:
			_replenish_resources()

	var card = resourceCards.pop_back()
	return card


func _on_stack_resources_pressed() -> void:
	var card = _draw_resource()
	# TODO simplify
	get_parent().players[get_parent().currentPlayer].add_resource(card)
	action_used.emit()

func _replenish_resources():
	resourceCards = graveyardResources.duplicate()
	resourceCards.shuffle()
	graveyardResources = []
	
func _replenish_characters():
	characterCards = graveyardCharacters.duplicate()
	characterCards.shuffle()
	graveyardCharacters = []
	
func _on_stack_characters_pressed() -> void:
	if characterCards.size() == 0:
		if graveyardCharacters.size() == 0:
			print("No more character cards left in stack or graveyard!")
			# TODO: do not continue
		else:
			_replenish_characters()

	var card = characterCards.pop_back()
	get_parent().players[get_parent().currentPlayer].add_character(card)
	action_used.emit()

## Move the card to the player's hand
func _on_resource_card_pressed(card: TextureButton) -> void:
	get_parent().players[get_parent().currentPlayer].add_resource(card.value)
	place_resource(card.slot)
	card.queue_free()
	action_used.emit()

func place_resource(slot: int):
	var value = _draw_resource()

	var card_node = load("res://card_resource.tscn").instantiate() as TextureButton
	card_node.texture_normal = load("res://assets/resource" + str(value) + ".png")
	card_node.custom_minimum_size = Vector2(CARD_WIDTH, 200.0)
	card_node.value = value
	card_node.visible = visible
	card_node.slot = slot
	add_child(card_node)
	cardsLaidOut[slot] = card_node

	card_node.position.x = 24.0 + (1 + slot) * (CARD_WIDTH + 24.0)
	card_node.position.y = 256
	
	card_node.pressed.connect(_on_resource_card_pressed.bind(card_node))

## Moves the card to the player's hand
func _on_character_card_pressed(card: TextureButton) -> void:
	get_parent().players[get_parent().currentPlayer].add_character(card.cost, card.diamondCost, card.points, card.diamonds)
	card.queue_free()
	place_character(card.slot)
	action_used.emit()

func place_character(slot: int):
	if characterCards.size() == 0:
		if graveyardCharacters.size() == 0:
			print("No more character cards left in stack or graveyard!")
			return
		else:
			_replenish_characters()

	var card = characterCards.pop_back()
	
	var card_node = load("res://card_character.tscn").instantiate() as TextureButton
	card_node.texture_normal = load("res://assets/character-" + str(concat(card.cost)) + "-" + str(card.diamondCost) + "-" + str(card.points) + "-" + str(card.diamonds) + ".png")
	card_node.custom_minimum_size = Vector2(CARD_WIDTH, 200.0)
	card_node.cost = card.cost
	card_node.diamondCost = card.diamondCost
	card_node.points = card.points
	card_node.diamonds = card.diamonds
	card_node.visible = visible
	card_node.slot = slot
	add_child(card_node)

	card_node.position.x = $StackCharacters.position.x - (1 + slot) * (CARD_WIDTH + 24.0)
	card_node.position.y = 256
	
	card_node.pressed.connect(_on_character_card_pressed.bind(card_node))

func concat(arr: Array) -> String:
	var result = ""
	for num in arr:
		result += str(num)
	return result


signal action_used()

## Places 4 new cards
func _on_button_pressed() -> void:
	for i in cardsLaidOut.size():
		graveyardResources.append(cardsLaidOut[i].value)
		cardsLaidOut[i].queue_free()
		place_resource(i)
	action_used.emit()
