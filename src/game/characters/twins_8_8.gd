class_name TwinsEightEight
extends CardCharacter

func _init():
	points = 2
	

func buy(player: PlayerArea) -> bool:
	return _is_owner(player) and _has_selected(player, [8, 8])
