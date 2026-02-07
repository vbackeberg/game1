class_name MotherSevenSevenSevenSeven
extends CardCharacter

func _init():
	points = 4
	

func buy(player: PlayerArea) -> bool:
	return _is_owner(player) and _has_selected(player, [7, 7, 7, 7])
