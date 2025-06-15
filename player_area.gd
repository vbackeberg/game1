extends Node2D

const CARD_WIDTH = 128.0
var resourceCards: Array[Node]
var characterCards: Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resourceCards = []
	characterCards = []

## Appends and prints card
func add_resource(value: int):
	var card_node = load("res://card_resource.tscn").instantiate() as TextureButton
	card_node.custom_minimum_size = Vector2(CARD_WIDTH, 200.0)
	card_node.texture_normal = load("res://assets/resource" + str(value) + ".png")
	card_node.value = value
	card_node.visible = visible # Match parent's visibility
	resourceCards.append(card_node)
	add_child(card_node)
	
	var card_index = resourceCards.size() - 1
	card_node.position.x = 24.0 + card_index * (CARD_WIDTH + 24.0)
	card_node.position.y = get_viewport().size.y / 2

## Takes character card
func add_character(cost, diamondCost, points, diamonds):
	if characterCards.size() == 2:
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
		characterCards.append(card_node)
		add_child(card_node)

		var card_index = characterCards.size()
		card_node.position.x = get_viewport().size.x - 24.0 - card_index * (CARD_WIDTH + 24.0)
		print(get_viewport().size.x)
		print(24.0)
		print(card_index)
		print(CARD_WIDTH + 24.0)
		card_node.position.y = get_viewport().size.y / 2

func _on_visibility_changed() -> void:
	for card in resourceCards:
		card.visible = visible
	
	for card in characterCards:
		card.visible = visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func concat(arr: Array) -> String:
	var result = ""
	for num in arr:
		result += str(num)
	return result
