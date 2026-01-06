class_name ExchangeStreet
extends CardCharacter

func _init():
	points = 2
	asset_path = "res://assets/characters/exchange-street.png"

func buy(player: PlayerArea) -> bool:
	return _is_owner(player) and _is_street_of_n(player, 5)
