class_name NeighborsFourFive
extends CardCharacter

func _init():
	super._init(3, 0, "neighbors-4-5")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes_either_or(player, [4, 4, 4], [5, 5, 5])
		if paid:
			return paid
	return null
