extends Node2D

const CARD_WIDTH = 128.0

var cardsLaidOut: Array[CardResource]

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
	get_parent().currentPlayer.add_resource(value)
	action_used.emit()
	
func _on_stack_characters_pressed() -> void:
	if get_parent().currentPlayer.charactersOnPayField.size() == 2:
		print("Player has 2 character cards, already.")
		return

	var card = GameManager.draw_character()
	get_parent().currentPlayer.add_character(card)
	action_used.emit()

## Move the card to the player's hand
func _on_resource_card_pressed(card: CardResource) -> void:
	get_parent().currentPlayer.add_resource(card.resourceValue)
	place_resource(card.slot)
	card.queue_free()
	action_used.emit()

func place_resource(slot: int):
	var value = GameManager.draw_resource()

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
	if get_parent().currentPlayer.charactersOnPayField.size() == 2:
		print("Player has 2 character cards, already.")
		return

	card.pressed.disconnect(_on_character_card_pressed)
	remove_child(card)
	get_parent().currentPlayer.add_character(card)
	place_character_in_middle(card.slot)
	action_used.emit()

func place_character_in_middle(slot: int):
	var card = GameManager.draw_character()
	card.slot = slot
	self.add_child(card)

	card.position.x = $StackCharacters.position.x - (1 + slot) * (CARD_WIDTH + 24.0)
	card.position.y = 256
	card.pressed.connect(_on_character_card_pressed.bind(card))

func concat(arr: Array) -> String:
	var result = ""
	for num in arr:
		result += str(num)
	return result


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
