class_name LionEightEightEightEight
extends CardCharacter

func _init():
	points = 5
	asset_path = "res://assets/characters/lion-8-8-8-8.png"

func buy(player: PlayerArea) -> Variant:
	return _is_owner(player) and _find(player, [8, 8, 8, 8])
