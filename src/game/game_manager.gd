extends Node

var resourceCards: Array[int]
var characterCards: Array
var graveyardResources: Array[int]
var graveyardCharacters: Array[CardCharacter]

func _init() -> void:
	resourceCards = [1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8]
	resourceCards.shuffle()

	characterCards = Characters.get_cards()
	characterCards.shuffle()


func draw_resource() -> int:
	if resourceCards.size() == 0:
		if graveyardResources.size() == 0:
			print("No more resource cards left in stack or graveyard!")
		else:
			_replenish_resources()

	return resourceCards.pop_back()

var backsideTexture = preload("res://assets/character_back.png")

func draw_character(backside: bool = false) -> CardCharacter:
	if characterCards.size() == 0:
		if graveyardCharacters.size() == 0:
			print("No more character cards left in stack or graveyard!")
		else:
			_replenish_characters()

	var card = characterCards.pop_back().instantiate()
	if backside:
		card.texture_normal = backsideTexture

	return card

func _replenish_resources():
	resourceCards = graveyardResources.duplicate()
	resourceCards.shuffle()
	graveyardResources = []

func _replenish_characters():
	characterCards = graveyardCharacters.duplicate()
	characterCards.shuffle()
	graveyardCharacters = []
