class_name PirateTwoTwoTwo
extends CardCharacter

func _init():
	points = 3
	

func buy(player: PlayerArea) -> bool:
	return _is_owner(player) and player.selectedDiamonds.size() == 1 and _has_selected(player, [2, 2, 2])
