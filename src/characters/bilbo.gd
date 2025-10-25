class_name Bilbo
extends CardCharacter

var even: bool

func _init(p_even, res):
	even = p_even
	super._init(1, 1, res)

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _is_three_odd_or_even(player, even)
		if paid:
			return paid
	return null
