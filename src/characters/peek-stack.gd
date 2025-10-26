class_name PeekStack
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/peek-stack.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 3):
		return null

	var resources = _is_street_of_n(player, 3)
	if not resources:
		return null

	self.pressed.connect(_pressed)

	return {
		resources = resources,
		diamonds = []
	}

func _pressed():
	# TODO: When player presses before turn start show first card of character stack
	pass
	

