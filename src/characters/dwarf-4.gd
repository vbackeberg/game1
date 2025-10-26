class_name DwarfFour
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/dwarf-4.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 2):
		return null

	var resources = _find(player, [4, 4])
	if not resources:
		return null

	self.pressed.connect(_pressed)

	return {
		resources = resources,
		diamonds = []
	}

func _pressed():
	playerOwner.selectedVirtualResources.append(4)
