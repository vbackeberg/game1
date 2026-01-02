class_name MotherSevenSevenSevenSeven
extends CardCharacter

func _init():
	points = 4
	asset_path = "res://assets/characters/mother-7-7-7-7.png"

func buy(player: PlayerArea) -> Variant:
	return _is_owner(player) and _find(player, [7, 7, 7, 7])
