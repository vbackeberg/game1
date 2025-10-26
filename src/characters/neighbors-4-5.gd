class_name NeighborsFourFive
extends CardCharacter

func _init():
	points = 3
	asset_path = "res://assets/characters/neighbors-4-5.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 3):
		return null
	
	var resources = _find_either_or(player, [4, 4, 4], [5, 5, 5])
	if not resources:
		return null

	return {resources = resources, diamonds = []}
