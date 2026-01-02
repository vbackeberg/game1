class_name PirateTwoTwoTwo
extends CardCharacter

func _init():
	points = 3
	asset_path = "res://assets/characters/pirate-2-2-2.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 3):
		return null

	if player.selectedDiamonds.size() != 1:
		return null

	var diamond = player.selectedDiamonds.pop_back()

	var resources = _find(player, [2, 2, 2])
	if not resources:
		return null

	return {
		resources = resources,
		diamonds = [diamond]
	}
