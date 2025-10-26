class_name DogOneOneOneOne
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/dog-1-1-1-1.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player):
		return null

	var resources = _find(player, [1, 1, 1, 1])
	if not resources:
		return null
		
	self.pressed.connect(_pressed)

	return {
		resources = resources,
		diamonds = []
	}

func _pressed():
	# TODO: Let player choose resource
	playerOwner.selectedVirtualResources.append( 0 )
	
