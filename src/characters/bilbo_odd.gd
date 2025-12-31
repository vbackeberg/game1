class_name BilboOdd
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/bilbo-odd.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 3):
		return null
	
	var resources = _is_three_odd_or_even(player, false)
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
