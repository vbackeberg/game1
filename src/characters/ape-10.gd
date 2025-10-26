class_name ApeTen
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/ape-10.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player):
		return null

	var resources = _sums_up_to_s(player, 10)
	if not resources:
		return null
	
	return {resources = resources, diamonds = []}
