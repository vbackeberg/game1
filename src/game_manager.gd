extends Node

var resourceCards: Array[int]
var characterCards: Array[Resource]
var graveyardResources: Array[int]
var graveyardCharacters: Array[CardCharacter]

func _init() -> void:
	resourceCards = [1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8]
	resourceCards.shuffle()

	characterCards = Characters.get_characters()
	characterCards.shuffle()


func draw_resource() -> int:
	if resourceCards.size() == 0:
		if graveyardResources.size() == 0:
			print("No more resource cards left in stack or graveyard!")
		else:
			_replenish_resources()

	return resourceCards.pop_back()


func draw_character():
	if characterCards.size() == 0:
		if graveyardCharacters.size() == 0:
			print("No more character cards left in stack or graveyard!")
		else:
			_replenish_characters()

	return characterCards.pop_back()

func _replenish_resources():
	resourceCards = graveyardResources.duplicate()
	resourceCards.shuffle()
	graveyardResources = []

func _replenish_characters():
	characterCards = graveyardCharacters.duplicate()
	characterCards.shuffle()
	graveyardCharacters = []
