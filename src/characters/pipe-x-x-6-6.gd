class_name PipeXXSixSix
extends CardCharacter

func _init():
	super._init(2, 1, "pipe-x-x-6-6")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [6, 6, 8, 8])
		if paid:
			return paid
	return null
