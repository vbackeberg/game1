class_name LionEightEightEightEight
extends CardCharacter

func _init():
	points = 5
	asset_path = "res://assets/characters/lion-8-8-8-8.png"

func buy(player: PlayerArea) -> bool:
	return _is_owner(player) and _has_selected(player, [8, 8, 8, 8])
