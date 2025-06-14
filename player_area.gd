extends Node2D

const CARD_SPACING = 200 # Space between resourceCards in pixels
const CARD_WIDTH = 128.0
var resourceCards: Array[Node] # Changed from Array[int] to Array[Node] to store card nodes
var characterCards: Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resourceCards = []

## Appends and prints card
func add_resource(value: int):
	var card_node = load("res://card_resource.tscn").instantiate() as TextureButton
	card_node.custom_minimum_size = Vector2(CARD_WIDTH, 200.0)
	card_node.texture_normal = load("res://assets/resource1.png")
	card_node.value = value
	card_node.visible = visible # Match parent's visibility
	resourceCards.append(card_node)
	add_child(card_node)
	
	# Position the card horizontally from its left side
	var card_index = resourceCards.size() - 1
	card_node.position.x = card_index * CARD_SPACING + CARD_WIDTH / 2
	card_node.position.y = get_viewport().size.y / 2

## Takes character card
func add_character(card: Dictionary):
	if characterCards.size() == 2:
		print("Player has 2 character cards, already.")
	
	else:
		var card_node = load("res://card_character.tscn").instantiate()
		card_node.size = Vector2(CARD_WIDTH, 200.0)
		card_node.texture_normal = load("res://assets/character1.png")
		card_node.cost = card.cost
		card_node.points = card.points
		card_node.visible = visible
		characterCards.append(card_node)
		add_child(card_node)

		var card_index = characterCards.size() - 1
		card_node.position.x = card_index * CARD_SPACING - CARD_WIDTH / 2
		card_node.position.y = get_viewport().size.y / 2

func _on_visibility_changed() -> void:
	for card in resourceCards:
		card.visible = visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
