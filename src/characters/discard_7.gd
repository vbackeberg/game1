class_name DiscardSeven
extends CardCharacter

func _init():
	points = 1
	

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player):
		return false

	return _sums_up_to_s_using_exactly_n(player, 7, 3)
