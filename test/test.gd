extends Node

var player: PlayerArea

func _ready() -> void:
	player = $Main.players[0]
	give_player_character("actions-1-3-5-7")
	give_player_resource(1)
	give_player_resource(3)
	give_player_resource(5)
	give_player_resource(7)
	

func give_player_character(cardName: String) -> void:
	var idx = GameManager.characterCards.find_custom(func(c): return c.asset_path == "res://assets/characters/" + cardName + ".png")
	var card = GameManager.characterCards.pop_at(idx)
	player.add_character(card)

func give_player_resource(value: int) -> void:
	GameManager.resourceCards.remove_at(GameManager.resourceCards.find(value))
	player.add_resource(value)
