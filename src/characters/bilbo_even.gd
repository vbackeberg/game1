class_name BilboEven
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/bilbo-even.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _is_three_odd_or_even(player, true):
		return false

	_immediate_effect()

	return true

func _immediate_effect():
	GameManager.draw_character()
