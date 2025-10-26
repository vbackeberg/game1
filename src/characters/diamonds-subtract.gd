class_name DiamondsSubtract
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/diamonds-subtract.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 1):
		return null
	
	var resources = _find(player, [3, 5, 7])
	if not resources:
		return null

	_immediate_effect()

	return {
		resources = resources,
		diamonds = []
	}

func _immediate_effect():
	MiddleArea.draw_diamond()

# TODO: Enable subtraction when playing diamond