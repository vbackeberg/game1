class_name TwinsEightEight
extends CardCharacter

func _init():
	points = 2
	asset_path = "res://assets/characters/twins-8-8.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 2):
		return null

	var resources = _find(player, [8, 8])
	if not resources:
		return null

	return {
		resources = resources,
		diamonds = []
	}
