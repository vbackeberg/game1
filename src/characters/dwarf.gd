class_name Dwarf
extends CardCharacter

var number: int

func _init(p_number):
	number = p_number
	super._init(1, 0, "dwarf-" + str(number))

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [number, number])
		if paid:
			player.selectedVirtualResources.append(number)
			return paid
	return null
