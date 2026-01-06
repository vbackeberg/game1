class_name DiamondsSubtract
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/diamonds-subtract.png"

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player) or not _n_resources_selected(player, 1):
		return false

	if not _has_selected(player, [3, 5, 7]):
		return false

	_immediate_effect()

	return true

func _immediate_effect():
	GameManager.draw_character()

# TODO: Enable subtraction when playing diamond
