class_name ApeTen
extends CardCharacter

func _init():
	super._init(1, 0, "ape-10")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _sums_up_to_s(player, 10)
		if paid:
			
			player.resourceCapacity += 1
			return paid
	return null
