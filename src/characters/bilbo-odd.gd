class_name BilboOdd
extends CardCharacter

func _init():
	super._init(1, 1, "bilbo-odd")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _is_three_odd_or_even(player, false)
		if paid:
			return paid
	return null
