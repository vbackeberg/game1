class_name DwarfThree
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/dwarf-3.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 2):
		return null

	var resources = _find(player, [3, 3])
	if not resources:
		return null

	self.pressed.connect(_on_pressed)

	return {
		resources = resources,
		diamonds = []
	}

func _on_pressed():
	playerOwner.selectedVirtualResources.append(3)
