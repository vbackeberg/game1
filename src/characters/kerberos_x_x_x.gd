class_name KerberosXXX
extends CardCharacter

func _init():
	points = 2
	

func buy(player: PlayerArea) -> bool:
	return _is_owner(player) and _has_n_of_same_kind(player, 3)