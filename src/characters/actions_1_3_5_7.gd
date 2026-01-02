extends CardCharacter

func _init():
	points = 2

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _find(player, [1, 3, 5, 7]):
		return false

	immediate_effect(player)

	return true


func immediate_effect(player: PlayerArea):
	player.actionsLeft += 3
