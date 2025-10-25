class_name DiscardSeven
extends CardCharacter

func _init():
	super._init(1, 0, "discard-7")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = sums_up_to_s_using_exactly_n(player, 7, 3)
		if paid:
			return paid
	return null
