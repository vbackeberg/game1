extends Node

var resourceCards: Array
var characterCards: Array
var graveyardResources: Array[CardResource]
var graveyardCharacters: Array[CardCharacter]

func _init() -> void:
	resourceCards = Resources.get_cards()
	resourceCards.shuffle()

	characterCards = Characters.get_cards()
	characterCards.shuffle()

var resourceBackside = preload("res://assets/resource_back.png")
func draw_resource(backside: bool = false) -> CardResource:
	if resourceCards.size() == 0:
		if graveyardResources.size() == 0:
			print("No more resource cards left in stack or graveyard!")
		else:
			_replenish_resources()

	var card = resourceCards.pop_back().instantiate()
	if backside:
		card.texture_normal = resourceBackside
	return card

var characterBackside = preload("res://assets/character_back.png")
func draw_character(backside: bool = false) -> CardCharacter:
	if characterCards.size() == 0:
		if graveyardCharacters.size() == 0:
			print("No more character cards left in stack or graveyard!")
		else:
			_replenish_characters()

	var card = characterCards.pop_back().instantiate()
	if backside:
		card.texture_normal = characterBackside

	return card

func _replenish_resources():
	resourceCards = graveyardResources.duplicate()
	resourceCards.shuffle()
	graveyardResources = []

func _replenish_characters():
	characterCards = graveyardCharacters.duplicate()
	characterCards.shuffle()
	graveyardCharacters = []
