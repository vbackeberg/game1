class_name PhoenixOneTwo
extends CardCharacter

func _init():
	points = 0
	asset_path = "res://assets/characters/phoenix-1-2.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 2):
		return null

	var resources = _find(player, [1, 2])
	if not resources:
		return null

	self.pressed.connect(_pressed)
	
	return {
		resources = resources,
		diamonds = []
	}

func _pressed():
	playerOwner.selectedVirtualResources.append(8)