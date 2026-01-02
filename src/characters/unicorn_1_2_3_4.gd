class_name UnicornOneTwoThreeFour
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/unicorn-1-2-3-4.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _find(player, [1, 2, 3, 4]):
		return false

	_immediate_effect()

	return true

func _immediate_effect():
	GameManager.draw_character()
	GameManager.draw_character()
