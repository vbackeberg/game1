extends Node

var player: PlayerArea

func _ready() -> void:
	player = $Main.players[0]
	give_player_character("three_for_wildcard")
	give_player_resource(3)
	give_player_resource(4)
	give_player_resource(3)
	give_player_resource(3)
	

func give_player_character(cardName: String) -> void:
	var idx = GameManager.characterCards.find_custom(func(c): return c.resource_path == "res://src/characters/" + cardName + ".tscn")
	if idx == -1:
		print("Test setup failed! Character card not found: " + cardName)
	var card = GameManager.characterCards.pop_at(idx).instantiate()
	player.add_character(card)

func give_player_resource(value: int) -> void:
	GameManager.resourceCards.remove_at(GameManager.resourceCards.find(value))
	player.add_resource(value)
