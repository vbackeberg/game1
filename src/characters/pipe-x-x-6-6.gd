class_name PipeXXSixSix
extends CardCharacter

func _init():
	points = 2
	asset_path = "res://assets/characters/pipe-x-x-6-6.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 4):
		return null

	var pair1 = _find(player, [6, 6])
	var pair2 = _find_n_of_same_kind(player, 2)
	if not pair1 or not pair2:
		return null
	
	pair1.append_array(pair2)
	return {
		resources = pair1,
		diamonds = []
	}
