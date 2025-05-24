extends Node2D

var cards: Array[int]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cards = []

## Appends and prints card
func add_card(card: int):
	cards.append(card)
	# Here you would also handle the visual representation of the card
	# For example, creating a sprite or UI element for the card
	for c in cards:
		print(c)


# Called every frame. 'de	lta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
