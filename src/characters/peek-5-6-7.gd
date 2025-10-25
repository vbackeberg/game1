class_name PeekFiveSixSeven
extends CardCharacter

func _init():
	super._init(1, 0, "peek-5-6-7")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [5, 6, 7])
		if paid:
			return paid
	return null
