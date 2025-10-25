class_name RedhoodFourFiveSixSevenEight
extends CardCharacter

func _init():
	super._init(1, 0, "redhood-4-5-6-7-8")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [4, 5, 6, 7, 8])
		if paid:
			
			player.actionsPerTurn += 1
			return paid
	return null
