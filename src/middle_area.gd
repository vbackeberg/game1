extends Node2D

const CARD_WIDTH = 128.0

var resourceCards: Array[int]
var characterCards: Array[Dictionary]
var cardsLaidOut: Array[TextureButton]

@export var graveyardResources: Array[int]
@export var graveyardCharacters: Array[Dictionary]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DiscardOverlay.visible = false

	resourceCards = [1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8]
	resourceCards.shuffle()
	
	characterCards = _load_character_cards()
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
func _on_resource_card_pressed(card: TextureButton) -> void:
	get_parent().currentPlayer.add_resource(card.value)
	place_resource(card.slot)
	card.queue_free()
	action_used.emit()

func place_resource(slot: int):
	var value = _draw_resource()

	var card_node = load("res://src/card_resource.tscn").instantiate() as TextureButton
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
	get_parent().currentPlayer.add_character(card.specs)
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

	var specs = characterCards.pop_back()
	
	var card_node = load("res://src/card_character.tscn").instantiate() as TextureButton
	card_node.texture_normal = load("res://assets/character-" + str(concat(specs.cost)) + "-" + str(specs.diamondCost) + "-" + str(specs.points) + "-" + str(specs.diamonds) + ".png")
	card_node.custom_minimum_size = Vector2(CARD_WIDTH, 200.0)
	card_node.specs = specs
	card_node.visible = visible
	card_node.slot = slot
	add_child(card_node)

	card_node.position.x = $StackCharacters.position.x - (1 + slot) * (CARD_WIDTH + 24.0)
	card_node.position.y = 256
	
	card_node.pressed.connect(_on_character_card_pressed.bind(card_node))

func draw_diamond():
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
		graveyardResources.append(cardsLaidOut[i].value)
		cardsLaidOut[i].queue_free()
		place_resource(i)
	action_used.emit()

func on_discard_started():
	$DiscardOverlay.visible = true
	$DiscardOverlay.move_to_front()

func on_discard_finished():
	$DiscardOverlay.visible = false

func _load_character_cards() -> Array[Dictionary]:
	return [
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [2, 2, 2]),
			diamondCost = 1,
			points = 3,
			diamonds = 0,
			effect = func(_player): pass
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [6, 6, 8, 8]),
			diamondCost = 0,
			points = 3,
			diamonds = 0,
			effect = func(_player): pass
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [6, 6, 8, 8]),
			diamondCost = 0,
			points = 3,
			diamonds = 0,
			effect = func(_player): pass
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [1, 3, 5, 7]),
			diamondCost = 0,
			points = 2,
			diamonds = 0,
			effect = func(player): player.actionsLeft += 3 # TODO refresh label
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [8, 8]),
			diamondCost = 0,
			points = 2,
			diamonds = 0,
			effect = func(_player): pass
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [8, 8]),
			diamondCost = 0,
			points = 2,
			diamonds = 0,
			effect = func(_player): pass
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [1, 1]),
			diamondCost = 0,
			points = 1,
			diamonds = 0,
			effect = func(player): player.additionalResources.add(1)
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [2, 2]),
			diamondCost = 0,
			points = 1,
			diamonds = 0,
			effect = func(player): player.additionalResources.add(2)
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [3, 3]),
			diamondCost = 0,
			points = 1,
			diamonds = 0,
			effect = func(player): player.additionalResources.add(3)
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [4, 4]),
			diamondCost = 0,
			points = 1,
			diamonds = 0,
			effect = func(player): player.additionalResources.add(4) # Take into account
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [5, 5]),
			diamondCost = 0,
			points = 1,
			diamonds = 0,
			effect = func(player): player.additionalResources.add(5)
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [6, 6]),
			diamondCost = 0,
			points = 1,
			diamonds = 0,
			effect = func(player): player.additionalResources.add(6)
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [7, 7]),
			diamondCost = 0,
			points = 1,
			diamonds = 0,
			effect = func(player): player.additionalResources.add(7)
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [1, 2, 3, 4]),
			diamondCost = 0,
			points = 1,
			diamonds = 2,
			effect = func(_player): pass
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [7, 7, 7, 7]),
			diamondCost = 0,
			points = 4,
			diamonds = 0,
			effect = func(_player): pass
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [7, 7, 7, 7]),
			diamondCost = 0,
			points = 4,
			diamonds = 0,
			effect = func(_player): pass
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [1, 2]),
			diamondCost = 0,
			points = 0,
			diamonds = 0,
			effect = func(player): player.additionalResources.add(7)
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [4, 5, 6, 7, 8]),
			diamondCost = 0,
			points = 1,
			diamonds = 0,
			effect = func(player): player.actionsPerTurn += 1
		},
		{
			cost = func(selectedResources: Array[int]): return _sums_up_to_using_exactly_three(selectedResources, 10),
			diamondCost = 0,
			points = 1,
			diamonds = 0,
			effect = func(player): pass # TODO can use a 1 as an 8
		},
		{
			cost = func(selectedResources: Array[int]): return _sums_up_to_in_any_combination(selectedResources, 10),
			diamondCost = 0,
			points = 1,
			diamonds = 0,
			effect = func(player): player.resourceCapacity += 1
		},
		{
			cost = func(selectedResources: Array[int]): return _sums_up_to_in_any_combination(selectedResources, 10),
			diamondCost = 0,
			points = 1,
			diamonds = 0,
			effect = func(player): player.resourceCapacity += 1
		},
		{
			cost = func(selectedResources: Array[int]): return _sums_up_to_in_any_combination(selectedResources, 10),
			diamondCost = 0,
			points = 1,
			diamonds = 0,
			effect = func(player): player.resourceCapacity += 1
		},
		{
			cost = func(selectedResources: Array[int]): return _includes(selectedResources, [3, 4, 5]),
			diamondCost = 0,
			points = 1,
			diamonds = 0,
			effect = func(_player): # TODO let player select one that should return to hand
		},
		{
			cost = func(selectedResources: Array[int]): return _includes_either_or(selectedResources, [3, 3, 3], [6, 6, 6]),
			diamondCost = 0,
			points = 3,
			diamonds = 0,
			effect = func(_player): pass #  TODO let neighbors play it
		},
		{
			cost = func(selectedResources: Array[int]): return _includes_either_or(selectedResources, [4, 4, 4], [5, 5, 5]),
			diamondCost = 0,
			points = 3,
			diamonds = 0,
			effect = func(_player): pass
		},

	]

## Checks if selected resources suffice to pay for the card.
## Returns the resources used to pay for the card or null if they do not suffice.
func _includes(selectedResources: Array[int], required: Array[int]):
	var selected = selectedResources.duplicate()
	var paid = []
	for r in required:
		var idx = selected.find(r)
		if idx == -1:
			return null
		paid.append(selected[idx])
		selected.remove_at(idx)
	return paid

## Checks if selected resources suffice to pay for the card for two alternatives.
## Returns the resources used to pay or null if they do not suffice.
func _includes_either_or(selectedResources: Array[int], eitherRequired: Array[int], orRequired: Array[int]):
	var paid = _includes(selectedResources, eitherRequired)
	if paid != null:
		return paid

	paid = _includes(selectedResources, orRequired)
	if paid != null:
		return paid

	return null

## Checks if a triple combination of the selected resources sum up to the given sum.
## Returns the triple used to make the sum.
func _sums_up_to_using_exactly_three(selectedResources: Array[int], sumUpTo: int):
	for i in range(selectedResources.size()):
		for j in range(i + 1, selectedResources.size()):
			for k in range(j + 1, selectedResources.size()):
				var triple = [selectedResources[i], selectedResources[j], selectedResources[k]]
				if triple[0] + triple[1] + triple[2] == sumUpTo:
					print("valid triple: ", triple)
					return triple
	return null

## Checks if any combination of selected resources sums up to the given value.
## Returns the first such combination found, or null if none exist.
func _sums_up_to_in_any_combination(selectedResources: Array[int], sumTo: int):
	var n = selectedResources.size()

	# Creates a binary mask that grows from 1 to 2^n as a selector for cards.
	# Then tries if the selected cards would sum up to sumTo.
	for mask in range(1, 1 << n):
		var combo = []
		var total = 0
		for i in range(n):
			if mask & (1 << i):
				combo.append(selectedResources[i])
				total += selectedResources[i]
		if total == sumTo:
			return combo
	return null
