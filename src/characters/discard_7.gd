class_name DiscardSeven
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/discard-7.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player):
		return null

	var resources = _sums_up_to_s_using_exactly_n(player, 7, 3)
	if not resources:
		return null

	return null
