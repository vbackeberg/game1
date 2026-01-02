class_name VikingSixSixEightEight
extends CardCharacter

func _init():
	points = 3
	asset_path = "res://assets/characters/viking-6-6-8-8.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _find(player, [6, 6, 8, 8]):
		return false

	return true
