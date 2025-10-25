class_name ActionsOneThreeFiveSeven
extends CardCharacter

func _init():
	super._init(2, 0, "actions-1-3-5-7")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [1, 3, 5, 7])
		if paid:
			
			player.actionsLeft += 1
			return paid
	return null
