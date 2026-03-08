class_name BombadilSevenSevenEightEight
extends CardCharacter

func _init():
	points = 3
	

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player) or not _n_resources_selected(player, 4):
		return false

	if not _has_selected(player, [7, 7, 8, 8]):
		return false

	_immediate_effect(player)

	return true

func _immediate_effect(player: PlayerArea):
	var card = GameManager.draw_character()
	player.add_diamond(card)
