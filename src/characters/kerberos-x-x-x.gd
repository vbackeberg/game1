class_name KerberosXXX
extends CardCharacter

func _init():
	points = 2
	asset_path = "res://assets/characters/kerberos-x-x-x.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player):
		return null

	var resources = _find_n_of_same_kind(player, 3)
	if not resources:
		return null
	
	return {
		resources = resources,
		diamonds = []
	}
