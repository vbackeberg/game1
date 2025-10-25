class_name ExchangeStreet
extends CardCharacter

func _init():
	super._init(2, 0, "exchange-street")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _is_street_of_n(player, 5)
		if paid:
			return paid
	return null
