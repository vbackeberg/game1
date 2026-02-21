class_name NeighborsFourFive
extends CardCharacter

func _init():
	points = 3
	

func buy(player: PlayerArea) -> bool:
	return _is_owner(player) and _has_either_or(player, [4, 4, 4], [5, 5, 5])
