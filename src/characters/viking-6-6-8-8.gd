class_name VikingSixSixEightEight
extends CardCharacter

func _init():
	super._init(3, 0, "viking-6-6-8-8")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [6, 6, 8, 8])
		if paid:
			return paid
	return null
