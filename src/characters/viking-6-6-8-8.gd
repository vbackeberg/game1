class_name VikingSixSixEightEight
extends CardCharacter

func _init():
	points = 3
	asset_path = "res://assets/characters/viking-6-6-8-8.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 4):
		return null

	var resources = _find(player, [6, 6, 8, 8])
	if not resources:
		return null

	return {
		resources = resources,
		diamonds = []
	}
