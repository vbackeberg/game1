class_name GoblinXX
extends CardCharacter

func _init():
	super._init(1, 0, "goblin-x-x")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _is_n_of_a_kind(player, 2)
		if paid:
			return paid
	return null
