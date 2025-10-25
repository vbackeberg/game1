class_name DiamondForTwo
extends CardCharacter

func _init():
	super._init(0, 1, "diamond-for-two")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [2])
		if paid:
			return paid
	return null
