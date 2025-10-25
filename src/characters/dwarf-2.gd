class_name DwarfTwo
extends CardCharacter

func _init():
	super._init(1, 0, "dwarf-2")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [2, 2])
		if paid:
			
			player.selectedVirtualResources.append(2)
			return paid
	return null
