class_name ApeTen
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/ape-10.png"

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player):
		return false

	return _sums_up_to_s(player, 10)