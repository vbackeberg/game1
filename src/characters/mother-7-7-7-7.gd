class_name MotherSevenSevenSevenSeven
extends CardCharacter

func _init():
	super._init(4, 0, "mother-7-7-7-7")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [7, 7, 7, 7])
		if paid:
			return paid
	return null
