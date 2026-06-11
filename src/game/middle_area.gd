extends Node3D

const CARD_WIDTH = 128.0

var cardsLaidOut: Array[CardResource]
@export var currentPlayer: PlayerArea

func _ready() -> void:
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

func _on_stack_resources_pressed() -> void:
	var value = GameManager.draw_resource()
	currentPlayer.add_resource(value)
	action_used.emit()
	
func _on_stack_characters_pressed() -> void:
	if currentPlayer.charactersOnPayField.size() == 2:
		print("Player has 2 character cards, already.")
		return

	var card = GameManager.draw_character()
	currentPlayer.add_character(card)
	action_used.emit()

## Move the card to the player's hand
func _on_resource_card_pressed(card: CardResource) -> void:
	currentPlayer.add_resource(card.resourceValue)
	place_resource(card.slot)
	card.queue_free()
	action_used.emit()

const resourceSlots = [-3.0, -2.0, -1.0, 0.0]

func place_resource(slot: int):
	var card = GameManager.draw_resource()
	card.slot = slot

	self.add_child(card)
	cardsLaidOut[slot] = card

	card.position.x = resourceSlots[slot]
	card.position.y = 256
	card.pressed.connect(_on_resource_card_pressed.bind(card))

## Moves the card to the player's hand
func _on_character_card_pressed(card: CardCharacter) -> void:
	if currentPlayer.charactersOnPayField.size() == 2:
		print("Player has 2 character cards, already.")
		return

	card.pressed.disconnect(_on_character_card_pressed)
	remove_child(card)
	currentPlayer.add_character(card)
	place_character_in_middle(card.slot)
	action_used.emit()

const characterSlots = [1.0, 2.0]

func place_character_in_middle(slot: int):
	var card = GameManager.draw_character()
	card.slot = slot

	self.add_child(card)
	card.position.x = characterSlots[slot]
	card.position.y = 256
	card.pressed.connect(_on_character_card_pressed.bind(card))

signal action_used()

## Places 4 new	 cards
func _on_new_cards_button_pressed() -> void:
	for i in cardsLaidOut.size():
		GameManager.graveyardResources.append(cardsLaidOut[i].resourceValue)
		cardsLaidOut[i].queue_free()
		place_resource(i)
	action_used.emit()

func on_discard_started():
	$DiscardOverlay.visible = true
	$DiscardOverlay.move_to_front()

func on_discard_finished():
	$DiscardOverlay.visible = false
