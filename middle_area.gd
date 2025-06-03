extends Node2D

const CARD_WIDTH = 100.0

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
