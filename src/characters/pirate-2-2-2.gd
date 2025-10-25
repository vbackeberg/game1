class_name PirateTwoTwoTwo
extends CardCharacter

func _init():
	super._init(3, 0, "pirate-2-2-2")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [2, 2, 2], 1)
		if paid:
			return paid
	return null
