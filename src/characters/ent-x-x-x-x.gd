class_name EntXXXX
extends CardCharacter

func _init():
	super._init(3, 0, "ent-x-x-x-x")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _is_n_of_a_kind(player, 4)
		if paid:
			return paid
	return null
