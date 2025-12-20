class_name BombadilSevenSevenEightEight
extends CardCharacter

func _init():
	points = 3
	asset_path = "res://assets/characters/bombadil-7-7-8-8.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 4):
		return null

	var resources = _find(player, [7, 7, 8, 8])
	if not resources:
		return null

	_immediate_effect(player)

	return {
		resources = resources,
		diamonds = []
	}

func _immediate_effect(player: PlayerArea):
	var card = GameManager.draw_character()
	player.add_diamond(card)