class_name VikingSixSixEightEight
extends CardCharacter

func _init():
	points = 3
	

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player) or not _has_selected(player, [6, 6, 8, 8]):
		return false

	return true
