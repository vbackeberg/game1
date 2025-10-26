class_name DiscardSeven
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/discard-7.png"

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _sums_up_to_s_using_exactly_n(player, 7, 3)
		if paid:
			return paid
	return null
