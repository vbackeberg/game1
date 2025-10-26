class_name UnicornOneTwoThreeFour
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/unicorn-1-2-3-4.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 4):
		return null

	var resources = _find(player, [1, 2, 3, 4])
	if not resources:
		return null

	_immediate_effect()
	
	return resources


func _immediate_effect():
	MiddleArea.draw_diamond()
	MiddleArea.draw_diamond()
