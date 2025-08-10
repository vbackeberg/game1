extends Node2D

const CARD_WIDTH = 128.0

var resourceCards: Array[int]
var characterCards: Array[CardCharacter]
var cardsLaidOut: Array[CardResource]

@export var graveyardResources: Array[int]
@export var graveyardCharacters: Array[CardCharacter]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DiscardOverlay.visible = false

	resourceCards = [1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8]
	resourceCards.shuffle()
	
	characterCards = _load_chars()
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
			# TODO: do not continue
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

## Places 4 new cards
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
	
func _load_chars() -> Array[CardCharacter]:
	return [
		CardCharacter.new(
			func(player, card): return _includes(player, [2, 2, 2], 1) if _is_owner(player, card) else null,
			3,
			0,
			"pirate"
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [6, 6], 0) if _is_owner(player, card) else null,
			1,
			0,
			"dwarf-6",
			func(_player): pass ,
			func(player): player.selectedVirtualResources.append(6)
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [7, 7], 0) if _is_owner(player, card) else null,
			1,
			0,
			"dwarf-7",
			func(_player): pass ,
			func(player): player.selectedVirtualResources.append(7)
		),
		CardCharacter.new(
			func(player):
				var paid = _includes(player, [6, 6, 6], 0)
				if paid == null:
					paid = _includes(player, [7, 7, 7], 0)
				return paid,
			3,
			0,
			"neighbors-6-8"
		),
		CardCharacter.new(
			func(player):
				var paid = _includes(player, [4, 4, 4], 0)
				if paid == null:
					paid = _includes(player, [5, 5, 5], 0)
				return paid,
			3,
			0,
			"neighbors-4-5"
		)
	]

func _includes(player: PlayerArea, requiredResources: Array[int], requiredDiamonds: int) -> Object:
	var paid = {
		resources = [],
		diamonds = []
		}

	while player.selectedVirtualResources.size() > 0:
		var value = player.selectedVirtualResources.pop_back()
		var idx = requiredResources.find(value)
		if idx == -1:
			return null
		else:
			requiredResources.remove_at(idx)
	
	while player.selectedResources.size() > 0:
		var card = player.selectedResources.pop_back()
		var idx = requiredResources.find(card.resourceValue)
		if idx == -1:
			return null
		else:
			requiredResources.remove_at(idx)
			paid.resources.append(card)


	while player.selectedDiamonds.size() > 0:
		requiredDiamonds -= 1
		paid.diamonds.append(player.selectedDiamonds.pop_back())


	if requiredDiamonds != 0 or requiredResources.size() > 0:
		return null

	return paid

func _sums_up_to_s_using_exactly_n(player: PlayerArea, s: int, n: int) -> Object:
	var paid = {
		resources = [],
		diamonds = []
		}

	while player.selectedVirtualResources.size() > 0:
		s -= player.selectedVirtualResources.pop_back()
		n -= 1

	while player.selectedResources.size() > 0:
		var card = player.selectedResources.pop_back()
		s -= card.value
		n -= 1
		paid.resources.append(card)

	if n != 0 or s != 0:
		return null

	return paid

func _sums_up_to_s(player: PlayerArea, s: int) -> Object:
	var paid = {
		resources = [],
		diamonds = []
		}
	
	while player.selectedVirtualResources.size() > 0:
		s -= player.selectedVirtualResources.pop_back()
	
	while player.selectedResources.size() > 0:
		var card = player.selectedResources.pop_back()
		s -= card.value
		paid.resources.append(card)

	if s != 0:
		return null
	
	return paid


func _is_owner(player: Node2D, card: CardCharacter) -> bool:
	return player == card.playerOwner

## Checks if the required number of identical cards are paid.
## Example: For a pair required is 2.
## Returns null if the player selected too many or too little resources.
## Otherwise returns paid resources and diamonds.
func _is_n_of_a_kind(player: PlayerArea, n: int) -> Object:
	var paid = {
		resources = [],
		diamonds = []
	}
	
	var value: int

	while player.selectedVirtualResources.size() > 0:
		if value == null:
			value = player.selectedVirtualResources.pop_back()
			n -= 1
		else:
			var nextValue = player.selectedVirtualResources.pop_back()
			if value == nextValue:
				n -= 1
			else:
				return null
	
	while player.selectedResources.size() > 0:
		if value == null:
			var nextCard = player.selectedResources.pop_back()
			value = nextCard.resourceValue
			paid.resource.append(nextCard)
			n -= 1
		else:
			var nextCard = player.selectedResources.pop_back()
			value = nextCard.resourceValue
			if value == nextCard.resourceValue:
				paid.resource.append(nextCard)
				n -= 1
			else:
				return null

	if n != 0:
		return null
	else:
		return paid
