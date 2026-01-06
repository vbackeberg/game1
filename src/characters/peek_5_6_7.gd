class_name PeekFiveSixSeven
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/peek-5-6-7.png"

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player) or not _has_selected(player, [5, 6, 7]):
		return false

	_immediate_effect()

	return true

func _immediate_effect():
	pass # TODO take card from opponent
