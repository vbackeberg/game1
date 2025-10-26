class_name ExchangeStreet
extends CardCharacter

func _init():
	points = 2
	asset_path = "res://assets/characters/exchange-street.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player):
		return null
		
	var resources = _is_street_of_n(player, 5)
	if not resources:
		return null
	
	return {
		resources = resources,
		diamonds = []
	}
