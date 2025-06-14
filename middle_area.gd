extends Node2D

const CARD_WIDTH = 128.0

var resourceCards: Array
var characterCards: Array[Dictionary]

@export var graveyardResources: Array
@export var graveyardCharacters: Array[Dictionary]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resourceCards = [1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8]
	resourceCards.shuffle()
	
	characterCards = [
		{
			cost = [8, 8],
			points = 2
		},
		{
			cost = [8, 8, 8, 8],
			points = 5
		},
		{
			cost = [2],
			points = 1
		}
	]
	characterCards.shuffle()
	
	graveyardResources = []
	graveyardCharacters = []

	place_resource(0)
	place_resource(1)
	place_resource(2)
	place_resource(3)
	
	# place_character(0)
	# place_character(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _draw_resource() -> int:
	if resourceCards.size() == 0:
		if graveyardResources.size() == 0:
			printerr("No more resource cards left in stack or graveyard!")
		else:
			_replenish_resources()

	var card = resourceCards.pop_back()
	print(card)
	return card


func _on_stack_resources_pressed() -> void:
	var card = _draw_resource()
	get_parent().playerArea.add_resource(card)

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
			printerr("No more character cards left in stack or graveyard!")
		else:
			_replenish_characters()

	var card = characterCards.pop_back()
	print(card)
	get_parent().playerArea.add_character(card)

func _on_resource_card_pressed(card: TextureButton) -> void:
	# Move the card to the player's hand
	get_parent().playerArea.add_resource(card.value)
	
	# Remove the card from the middle area
	card.queue_free()
	
	# Place a new resource card in the middle area
	place_resource(card.slot)

func place_resource(slot: int):
	var card = _draw_resource()

	var card_node = load("res://card_resource.tscn").instantiate() as TextureButton
	card_node.texture_normal = load("res://assets/resource" + str(card) + ".png")
	card_node.custom_minimum_size = Vector2(CARD_WIDTH, 200.0)
	card_node.value = card
	card_node.visible = visible
	card_node.slot = slot
	add_child(card_node)

	card_node.position.x = 24.0 + (1 + slot) * (CARD_WIDTH + 24.0)
	card_node.position.y = 256
	
	# Connect the pressed signal
	card_node.pressed.connect(_on_resource_card_pressed.bind(card_node))

	print(card_node.position)

# func _on_character_card_pressed(card: TextureButton) -> void:
# 	# Move the card to the player's hand
# 	get_parent().playerArea.add_character(card.cost, card.points)
	
# 	# Remove the card from the middle area
# 	card.queue_free()
	
# 	# Place a new character card in the middle area
# 	place_character(card.slot)

# func place_character(slot: int):
# 	if characterCards.size() == 0:
# 		if graveyardCharacters.size() == 0:
# 			printerr("No more character cards left in stack or graveyard!")
# 			return
# 		else:
# 			_replenish_characters()

# 	var card_data = characterCards.pop_back()
	
# 	var card_node = load("res://card_character.tscn").instantiate() as TextureButton
# 	card_node.texture_normal = load("res://assets/character" + str(card_data.cost) + "-" + str(card_data.points)
# 	card_node.custom_minimum_size = Vector2(CARD_WIDTH, 200.0)
# 	card_node.card_data = card_data
# 	card_node.visible = visible
# 	card_node.slot = slot
# 	add_child(card_node)

# 	card_node.position.x = 24.0 + (1 + slot) * (CARD_WIDTH + 24.0)
# 	card_node.position.y = 512  # Place character cards below resource cards
	
# 	# Connect the pressed signal
# 	card_node.pressed.connect(_on_character_card_pressed.bind(card_node))

# 	print(card_node.position)
