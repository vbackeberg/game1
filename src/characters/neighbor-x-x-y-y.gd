class_name NeighborXXYY
extends CardCharacter

func _init():
	super._init(2, 0, "neighbor-x-x-y-y")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _is_n_of_two_kinds(player, 2)
		if paid:
			return paid
	return null
