class_name DwarfThree
extends CardCharacter

func _init():
	super._init(1, 0, "dwarf-3")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [3, 3])
		if paid:
			
			player.selectedVirtualResources.append(3)
			return paid
	return null
