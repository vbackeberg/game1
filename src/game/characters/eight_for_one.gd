class_name EightForOne
extends CardCharacter

func _init():
	points = 1
	

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player):
		return false

	if not _sums_up_to_s_using_exactly_n(player, 10, 3):
		return false

	self.pressed.connect(_on_pressed)

	return true


func _on_pressed():
	playerOwner.selectedVirtualResources.append(1)
