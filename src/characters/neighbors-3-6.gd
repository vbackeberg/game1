class_name NeighborsThreeSix
extends CardCharacter

func _init():
	super._init(3, 0, "neighbors-3-6")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes_either_or(player, [3, 3, 3], [6, 6, 6])
		if paid:
			return paid
	return null
