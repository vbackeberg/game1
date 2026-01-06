class_name PipeXXSixSix
extends CardCharacter

func _init():
	points = 2
	asset_path = "res://assets/characters/pipe-x-x-6-6.png"

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player) or not _n_resources_selected(player, 4):
		return false

	var resources = []
	resources.append_array(player.selectedResources.duplicate())
	resources.append_array(player.selectedVirtualResources.duplicate())

	var indices = _find(resources, [6, 6])
	if indices.size() == 0:
		return false

	for i in indices:
		resources.remove_at(i)

	indices = _find_n_of_same_kind(resources, 2)
	if indices.size() == 0:
		return false

	return true