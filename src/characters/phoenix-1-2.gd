class_name PhoenixOneTwo
extends CardCharacter

func _init():
	super._init(0, 0, "phoenix-1-2")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [1, 2])
		if paid:
			
			player.selectedVirtualResources.append(8)
			return paid
	return null
