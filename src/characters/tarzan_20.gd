class_name TarzanTwenty
extends CardCharacter

func _init():
	points = 2
	asset_path = "res://assets/characters/tarzan-20.png"

func buy(player: PlayerArea) -> Variant:
	return _is_owner(player) and _sums_up_to_s_using_exactly_n(player, 20, 3)
