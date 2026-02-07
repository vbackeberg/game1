class_name ApeTen
extends CardCharacter

func _init():
	points = 1
	

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player):
		return false

	return _sums_up_to_s(player, 10)