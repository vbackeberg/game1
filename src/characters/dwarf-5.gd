class_name DwarfFive
extends CardCharacter

func _init():
	super._init(1, 0, "dwarf-5")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [5, 5])
		if paid:
			
			player.selectedVirtualResources.append(5)
			return paid
	return null
