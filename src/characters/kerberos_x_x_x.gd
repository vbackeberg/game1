class_name KerberosXXX
extends CardCharacter

func _init():
	points = 2
	asset_path = "res://assets/characters/kerberos-x-x-x.png"

func buy(player: PlayerArea) -> Variant:
	return _is_owner(player) and _find_n_of_same_kind(player, 3)