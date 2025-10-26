class_name EntXXXX
extends CardCharacter

func _init():
	points = 3
	asset_path = "res://assets/characters/ent-x-x-x-x.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 4):
		return null
	
	var resources = _find_n_of_same_kind(player, 4)
	if not resources:
			return null

	return {
		resources = resources,
		diamonds = []
	}

