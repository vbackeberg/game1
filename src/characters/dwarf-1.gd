class_name DwarfOne
extends CardCharacter

func _init():
	super._init(1, 0, "dwarf-1")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [1, 1])
		if paid:
			
			player.selectedVirtualResources.append(1)
			return paid
	return null
