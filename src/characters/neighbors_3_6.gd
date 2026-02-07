class_name NeighborsThreeSix
extends CardCharacter

func _init():
	points = 3
	

func buy(player: PlayerArea) -> bool:
	return _is_owner(player) and _has_either_or(player, [3, 3, 3], [6, 6, 6])
