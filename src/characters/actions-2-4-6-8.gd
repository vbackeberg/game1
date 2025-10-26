class_name ActionsTwoFourSixEight
extends CardCharacter

func _init():
	points = 2
	asset_path = "res://assets/characters/actions-2-4-6-8.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 4):
		return null

	var resources = _find(player, [2, 4, 6, 8])
	if not resources:
		return null

	immediate_effect(player)

	return {
		resources = resources,
		diamonds = []
	}

func immediate_effect(player: PlayerArea):
	player.actionsLeft += 3
