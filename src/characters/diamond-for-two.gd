class_name DiamondForTwo
extends CardCharacter

func _init():
	points = 0
	asset_path = "res://assets/characters/diamond-for-two.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 1):
		return null
	
	var resources = _find(player, [2])
	if not resources:
		return null

	_immediate_effect()

	return {
		resources = resources,
		diamonds = []
	}

func _immediate_effect():
	MiddleArea.draw_diamond()

# TODO: Allow playing 2s as diamonds