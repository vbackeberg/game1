class_name TarzanTwenty
extends CardCharacter

func _init():
	super._init(2, 0, "tarzan-20")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = sums_up_to_s_using_exactly_n(player, 20, 3)
		if paid:
			return paid
	return null
