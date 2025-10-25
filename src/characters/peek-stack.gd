class_name PeekStack
extends CardCharacter

func _init():
	super._init(1, 0, "peek-stack")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _is_street_of_n(player, 3)
		if paid:
			return paid
	return null
