class_name GoblinXX
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/goblin-x-x.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 2):
		return null

	var resources = _find_n_of_same_kind(player, 2)
	if not resources:
		return null

	return {
		resources = resources,
		diamonds = []
	}
