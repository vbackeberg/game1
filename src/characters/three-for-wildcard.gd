class_name ThreeForWildcard
extends CardCharacter

func _init():
	super._init(1, 0, "three-for-wildcard")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [3, 3, 3])
		if paid:
			return paid
	return null
