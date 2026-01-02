class_name BilboOdd
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/bilbo-odd.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _is_three_odd_or_even(player, false):
		return false

	_immediate_effect(player)

	return true

func _immediate_effect(player: PlayerArea):
	var card = GameManager.draw_character()
	player.add_diamond(card)
