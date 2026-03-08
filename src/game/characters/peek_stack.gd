class_name PeekStack
extends CardCharacter

func _init():
	points = 1
	

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player) or not _is_street_of_n(player, 3):
		return false

	self.pressed.connect(_on_pressed)

	return true

func _on_pressed():
	# TODO: When player presses before turn start show first card of character stack
	pass
	
