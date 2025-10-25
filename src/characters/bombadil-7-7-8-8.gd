class_name BombadilSevenSevenEightEight
extends CardCharacter

func _init():
	super._init(3, 1, "bombadil-7-7-8-8")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [7, 7, 8, 8])
		if paid:
			return paid
	return null
