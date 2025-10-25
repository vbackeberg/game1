class_name DwarfSix
extends CardCharacter

func _init():
	super._init(1, 0, "dwarf-6")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [6, 6], 0)
		if paid:
			
			player.selectedVirtualResources.append(6)
			return paid
	return null
