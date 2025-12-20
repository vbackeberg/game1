class_name DwarfSeven
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/dwarf-7.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 2):
		return null

	var resources = _find(player, [7, 7])
	if not resources:
		return null

	self.pressed.connect(_on_pressed)

	return {
		resources = resources,
		diamonds = []
	}

func _on_pressed():
	playerOwner.selectedVirtualResources.append(7)