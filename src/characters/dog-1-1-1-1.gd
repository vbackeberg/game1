class_name DogOneOneOneOne
extends CardCharacter

func _init():
	super._init(1, 0, "dog-1-1-1-1")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [1, 1, 1, 1], 0)
		if paid:
			
			player.selectedVirtualResources.append("*") # TODO placeholder
			return paid
	return null
