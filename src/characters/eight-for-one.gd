class_name EightForOne
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/eight-for-one.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player):
		return null

	var resources = _sums_up_to_s_using_exactly_n(player, 10, 3)
	if not resources:
		return null

	self.pressed.connect(_pressed)

	return {
		resources = resources,
		diamonds = []
	}


func _pressed():
	playerOwner.selectedVirtualResources.append(1)
