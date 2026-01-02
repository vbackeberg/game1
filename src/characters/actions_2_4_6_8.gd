extends CardCharacter

func _init():
	points = 2
	asset_path = "res://assets/characters/actions-2-4-6-8.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player):
		return false

	if not _find(player, [2, 4, 6, 8]):
		return false

	immediate_effect(player)

	return true

func immediate_effect(player: PlayerArea):
	player.actionsLeft += 3
