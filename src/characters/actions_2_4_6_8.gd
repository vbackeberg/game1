extends CardCharacter

func _init():
	points = 2
	

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player):
		return false

	if not _has_selected(player, [2, 4, 6, 8]):
		return false

	immediate_effect(player)

	return true

func immediate_effect(player: PlayerArea):
	player.actionsThisTurn += 3
