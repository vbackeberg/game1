class_name PirateTwoTwoTwo
extends CardCharacter

func _init():
	points = 3
	asset_path = "res://assets/characters/pirate-2-2-2.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 3):
		return null

	var diamond = player.selectedVirtualResources.pop_back()
	if not diamond:
		return null

	var resources = _find(player, [2, 2, 2])
	if not resources:
		return null

	self.pressed.connect(_pressed)

	return {
		resources = resources,
		diamonds = [diamond]
	}
