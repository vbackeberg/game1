extends Node

func _ready() -> void:
	var player = $Main.players[0]
	var card = $Main/MiddleArea.characterCards.find_custom(is_dog.bind())
	player.add_character(card)

	
func is_dog(card: CardCharacter):
	return card.asset_path == "res://assets/characters/dog-1-1-1-1.png"
