class_name DiamondsSubtract
extends CardCharacter

func _init():
	super._init(1, 1, "diamonds-subtract")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [3, 5, 7])
		if paid:
			return paid
	return null
