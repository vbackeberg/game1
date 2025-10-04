extends Node2D

const CARD_WIDTH = 128.0

var resourceCards: Array[int]
var characterCards: Array[CardCharacter]
var cardsLaidOut: Array[CardResource]

@export var graveyardResources: Array[int]
@export var graveyardCharacters: Array[CardCharacter]

func _ready() -> void:
	var characters = preload("res://src/characters.gd")

	$DiscardOverlay.visible = false

	resourceCards = [1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8]
	resourceCards.shuffle()
	
	characterCards = characters.load_cards()
	characterCards.shuffle()
	
	graveyardResources = []
	graveyardCharacters = []
	cardsLaidOut = []
	cardsLaidOut.resize(4)

	place_resource(0)
	place_resource(1)
	place_resource(2)
	place_resource(3)
	
	place_character_in_middle(0)
	place_character_in_middle(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
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
	get_parent().currentPlayer.add_resource(card)
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
	var card = _draw_character()
	get_parent().currentPlayer.add_character(card)
	action_used.emit()

func _draw_character():
	if characterCards.size() == 0:
		if graveyardCharacters.size() == 0:
			print("No more character cards left in stack or graveyard!")
		else:
			_replenish_characters()

	return characterCards.pop_back()

## Move the card to the player's hand
func _on_resource_card_pressed(card: CardResource) -> void:
	get_parent().currentPlayer.add_resource(card.resourceValue)
	place_resource(card.slot)
	card.queue_free()
	action_used.emit()

func place_resource(slot: int):
	var value = _draw_resource()

	var card_node = load("res://src/card_resource.tscn").instantiate() as CardResource
	card_node.texture_normal = load("res://assets/resource" + str(value) + ".png")
	card_node.custom_minimum_size = Vector2(CARD_WIDTH, 200.0)
	card_node.resourceValue = value
	card_node.visible = visible
	card_node.slot = slot
	add_child(card_node)
	cardsLaidOut[slot] = card_node

	card_node.position.x = 24.0 + (1 + slot) * (CARD_WIDTH + 24.0)
	card_node.position.y = 256
	
	card_node.pressed.connect(_on_resource_card_pressed.bind(card_node))

## Moves the card to the player's hand
func _on_character_card_pressed(card: CardCharacter) -> void:
	card.pressed.disconnect(_on_character_card_pressed)
	remove_child(card)
	get_parent().currentPlayer.add_character(card)
	place_character_in_middle(card.slot)
	action_used.emit()

func place_character_in_middle(slot: int):
	if characterCards.size() == 0:
		if graveyardCharacters.size() == 0:
			print("No more character cards left in stack or graveyard!")
			return
		else:
			_replenish_characters()

	var card = characterCards.pop_back()
	
	card.visible = visible
	card.slot = slot
	add_child(card)

	card.position.x = $StackCharacters.position.x - (1 + slot) * (CARD_WIDTH + 24.0)
	card.position.y = 256
	card.pressed.connect(_on_character_card_pressed.bind(card))

func _draw_diamond():
	var card = characterCards.pop_back()
	get_parent().currentPlayer.add_diamond(card)

func concat(arr: Array) -> String:
	var result = ""
	for num in arr:
		result += str(num)
	return result


signal action_used()

## Places 4 new	 cards
func _on_button_pressed() -> void:
	for i in cardsLaidOut.size():
		graveyardResources.append(cardsLaidOut[i].resourceValue)
		cardsLaidOut[i].queue_free()
		place_resource(i)
	action_used.emit()

func on_discard_started():
	$DiscardOverlay.visible = true
	$DiscardOverlay.move_to_front()

func on_discard_finished():
	$DiscardOverlay.visible = false
