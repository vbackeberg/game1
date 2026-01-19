extends Node

var player: PlayerArea

func _ready() -> void:
	player = $Main.players[0]
	give_player_character("actions_1_3_5_7")
	give_player_character("dwarf_1")
	give_player_resource(1)
	give_player_resource(1)
	give_player_resource(3)
	give_player_resource(5)
	give_player_resource(7)
	

func give_player_character(cardName: String) -> void:
	var idx = GameManager.characterCards.find_custom(func(c): return c.resource_path == "res://src/characters/" + cardName + ".tscn")
	var card = GameManager.characterCards.pop_at(idx).instantiate()
	player.add_character(card)

func give_player_resource(value: int) -> void:
	GameManager.resourceCards.remove_at(GameManager.resourceCards.find(value))
	player.add_resource(value)