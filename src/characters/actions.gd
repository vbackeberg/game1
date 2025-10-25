class_name Actions
extends CardCharacter

var cost: Array[int]

func _init(p_cost):
	cost = p_cost
	super._init(2, 0, "actions-{0}-{1}-{2}-{3}".format(cost))

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, cost)
		if paid:
			
			player.actionsLeft += 1
			return paid
	return null
