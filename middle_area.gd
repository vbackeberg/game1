extends Node2D
var cards: Array


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cards = [1,2,3,4]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_stack_resources_pressed() -> void:
	if cards.size() == 0:
		_replenish()

	var card = cards.pop_back()
	print(card)
	get_parent().playersHand.add_card(card)
func _replenish():
	pass
