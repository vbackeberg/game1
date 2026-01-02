class_name NeighborsThreeSix
extends CardCharacter

func _init():
	points = 3
	asset_path = "res://assets/characters/neighbors-3-6.png"

func buy(player: PlayerArea) -> Variant:
	return _is_owner(player) and _find_either_or(player, [3, 3, 3], [6, 6, 6])
