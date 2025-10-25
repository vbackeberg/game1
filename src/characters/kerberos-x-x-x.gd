class_name KerberosXXX
extends CardCharacter

func _init():
	super._init(2, 0, "kerberos-x-x-x")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _is_n_of_a_kind(player, 3)
		if paid:
			return paid
	return null
