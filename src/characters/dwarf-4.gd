class_name DwarfFour
extends CardCharacter

func _init():
	super._init(1, 0, "dwarf-4")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [4, 4])
		if paid:
			
			player.selectedVirtualResources.append(4)
			return paid
	return null
