class_name UnicornOneTwoThreeFour
extends CardCharacter

func _init():
	super._init(1, 2, "unicorn-1-2-3-4")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [1, 2, 3, 4])
		if paid:
			return paid
	return null
