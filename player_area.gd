extends Node2D

const CARD_SPACING = 200 # Space between resourceCards in pixels
var resourceCards: Array[Node] # Changed from Array[int] to Array[Node] to store card nodes
var characterCards: Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resourceCards = []

## Appends and prints card
func add_resource(card: int):
	var card_node = load("res://card_resource.tscn").instantiate()
	card_node.value = card
	card_node.visible = visible # Match parent's visibility
	resourceCards.append(card_node)
	add_child(card_node)
	
	# Position the card horizontally from its left side
	var card_index = resourceCards.size() - 1
	card_node.position.x = card_index * CARD_SPACING + card_node.texture.get_width() / 2
	card_node.position.y = get_viewport().size.y / 2

## Takes character card
func add_character(card: Dictionary):
	if characterCards.size() == 2:
		print("Player has 2 character cards, already.")
	
	var card_node = load("res://card_character.tscn").instantiate()
	card_node.cost = card.cost
	card_node.points = card.points
	card_node.visible = visible
	characterCards.append(card_node)
	add_child(card_node)

	var card_index = characterCards.size() - 1
	card_node.position.x = card_index * CARD_SPACING - card_node.texture.get_width() / 2
	card_node.position.y = get_viewport().size.y / 2

func _on_visibility_changed() -> void:
	for card in resourceCards:
		card.visible = visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
