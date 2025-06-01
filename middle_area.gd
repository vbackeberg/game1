extends Node2D
var resourceCards: Array
var characterCards: Array[Dictionary]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resourceCards = [1, 2, 3, 4]
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_stack_resources_pressed() -> void:
	if resourceCards.size() == 0:
		_replenish()

	var card = resourceCards.pop_back()
	print(card)
	get_parent().playerArea.add_resource(card)
	
func _replenish():
	pass
	
func _shuffle_graveyard():
	pass

func _on_stack_characters_pressed() -> void:
	if characterCards.size() == 0:
		_shuffle_graveyard()

	var card = characterCards.pop_back()
	print(card)	
	get_parent().playerArea.add_character(card)
