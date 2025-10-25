class_name TwinsEightEight
extends CardCharacter

func _init():
	super._init(2, 0, "twins-8-8")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [8, 8])
		if paid:
			return paid
	return null
