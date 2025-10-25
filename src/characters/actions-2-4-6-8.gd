class_name ActionsTwoFourSixEight
extends CardCharacter

func _init():
	super._init(2, 0, "actions-2-4-6-8")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [2, 4, 6, 8])
		if paid:
			
			player.actionsLeft += 1
			return paid
	return null
