class_name NeighborsThreeSix
extends CardCharacter

func _init():
	points = 3
	asset_path = "res://assets/characters/neighbors-3-6.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 3):
		return null
	
	var resources = _find_either_or(player, [3, 3, 3], [6, 6, 6])
	if not resources:
		return null

	return {resources = resources, diamonds = []}
