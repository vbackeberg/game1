class_name NeighborsFourFive
extends CardCharacter

func _init():
	points = 3
	asset_path = "res://assets/characters/neighbors-4-5.png"

func buy(player: PlayerArea) -> Variant:
	return _is_owner(player) and _find_either_or(player, [4, 4, 4], [5, 5, 5])
