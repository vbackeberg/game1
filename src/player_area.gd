extends Node2D

const CARD_WIDTH = 128.0
var playerName: String
var resourcesOnHand: Array[CardResource]
var resourceCapacity: int
var additionalResources: Array[int]
var charactersOnPayField: Array[CardCharacter]
var diamonds: Array[CardCharacter]
var selectedResources: Array[CardResource]
var selectedDiamonds: Array[CardCharacter]
var charactersPlayed: Array[CardCharacter]
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

## Appends card
func add_resource(value: int):
	var card_node = load("res://src/card_resource.tscn").instantiate() as CardResource
	card_node.custom_minimum_size = Vector2(CARD_WIDTH, 200.0)
	card_node.texture_normal = load("res://assets/resource" + str(value) + ".png")
	card_node.resourceValue = value
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
func _on_resource_card_pressed(card: CardResource) -> void:
	var index = selectedResources.find(card)
	if discardMode:
		if index == -1:
			if selectedResources.size() == numToDiscard:
				return

			selectedResources.append(card)
			card.select(true)
		else:
			selectedResources.remove_at(index)
			card.deselect()
		
		if selectedResources.size() == numToDiscard:
			$ConfirmDiscardButton.visible = true
		else:
			$ConfirmDiscardButton.visible = false

	else:
		if index == -1:
			selectedResources.append(card)
			card.select()
		else:
			selectedResources.remove_at(index)
			card.deselect()

func _on_confirm_discard_button_pressed() -> void:
	for r in selectedResources:
		get_parent().on_resource_spent(r.resourceValue)
		resourcesOnHand.erase(r)
		r.queue_free()
		numToDiscard -= 1
		if numToDiscard == 0:
			$ConfirmDiscardButton.visible = false
			discardMode = false
			_reorder_resource_cards()
			discard_finished.emit()

## Adds a character card with given specs and puts it on the right side.
func add_character(card: CardCharacter):
	if charactersOnPayField.size() == 2:
		# TODO prevent player from doing that
		print("Player has 2 character cards, already.")
	
	else:
		card.visible = visible
		card.playerOwner = self
		charactersOnPayField.append(card)
		add_child(card)

		var card_index = charactersOnPayField.size()
		card.position.x = get_viewport().size.x - 24.0 - card_index * (CARD_WIDTH + 24.0)
		card.position.y = get_viewport().size.y / 2
		
		card.pressed.connect(_on_unplayed_character_card_pressed.bind(card))

# If any in paid is null, player cannot play the character.
# Removes spent resources and diamonds and puts them on graveyard
func _on_unplayed_character_card_pressed(card: CardCharacter) -> void:
	var paid = card.buy.call(self, card)
	if paid.resources == null or paid.diamonds == null:
		print("not enough resources selected")
		# TODO show label with missing resources
	else:
		for r in paid.resources:
			get_parent().on_resource_spent(r.resourceValue)
			resourcesOnHand.erase(r)
			r.queue_free()

		for r in selectedResources:
			r.deselect()

		selectedResources.clear()
		_reorder_resource_cards()
		
		for d in paid.diamonds:
			get_parent().on_diamond_spent(d)
			diamonds.erase(d)
			d.queue_free()

		selectedDiamonds.clear()
		_reorder_diamonds()
		
		_place_character_on_played_area(card)
		card.effect.call(self)
		
		action_used.emit()


## Places a character with its backside up.
## Note: Keeping track of the character is important in case it's reshuffled into the stack from the graveyard, later.
func add_diamond(card: CardCharacter):
	card.backside = true
	card.visible = visible
	diamonds.append(card)
	add_child(card)

	var card_index = diamonds.size()
	card.position.x = get_viewport().size.x - 24.0 - card_index * (CARD_WIDTH + 24.0)
	card.position.y = 24.0
	
	card.pressed.connect(_on_diamond_card_pressed.bind(card))


func _on_diamond_card_pressed(card: CardCharacter) -> void:
	var index = selectedDiamonds.find(card)

	if index == -1:
		selectedDiamonds.append(card)
		card.select()
	else:
		selectedDiamonds.remove_at(index)
		card.deselect()


func _place_character_on_played_area(card: CardCharacter):
	charactersPlayed.append(card)
	var card_index = charactersPlayed.size()
	card.position.x = 24.0 + card_index * (CARD_WIDTH + 24.0)
	card.position.y = 24.0 + 200.0
	card.rotation_degrees = 180
	card.pressed.disconnect(_on_unplayed_character_card_pressed)
	card.activate_permanent_effect()

	charactersOnPayField.erase(card)
	victoryPoints += card.points

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
