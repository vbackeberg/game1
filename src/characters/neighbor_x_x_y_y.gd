class_name NeighborXXYY
extends CardCharacter

func _init():
	points = 2
	asset_path = "res://assets/characters/neighbor-x-x-y-y.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 4):
		return null

	var pair1 = _find_n_of_same_kind(player, 2)
	var pair2 = _find_n_of_same_kind(player, 2)
	if not pair1 or not pair2:
		return null
	
	pair1.append_array(pair2)

	_immediate_effect()

	return {
		resources = pair1,
		diamonds = []
	}

func _immediate_effect():
	var main = get_node("/root/Main")
	var nextIdx = (main.currentPlayerIdx + 1) % main.players.size()
	main.players[nextIdx].actionsLeft += 1
