class_name EntXXXX
extends CardCharacter

func _init():
	points = 3
	

func buy(player: PlayerArea) -> bool:
	return _is_owner(player) and _has_n_of_same_kind(player, 4)