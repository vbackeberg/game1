class_name EntXXXX
extends CardCharacter

func _init():
	points = 3
	asset_path = "res://assets/characters/ent-x-x-x-x.png"

func buy(player: PlayerArea) -> bool:
	return _is_owner(player) and _has_n_of_same_kind(player, 4)