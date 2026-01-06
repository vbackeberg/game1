class_name GoblinXX
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/goblin-x-x.png"

func buy(player: PlayerArea) -> bool:
	return _is_owner(player) and _has_n_of_same_kind(player, 2)
