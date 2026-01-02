class_name DiamondForTwo
extends CardCharacter

func _init():
	points = 0
	asset_path = "res://assets/characters/diamond-for-two.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 1):
		return null
	
	if not _find(player, [2]):
		return false

	_immediate_effect(player)

	return true

func _immediate_effect(player: PlayerArea):
	var card = GameManager.draw_character()
	player.add_diamond(card)

# TODO: Allow playing 2s as diamonds
