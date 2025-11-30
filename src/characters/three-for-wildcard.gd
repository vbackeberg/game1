class_name ThreeForWildcard
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/three-for-wildcard.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 3):
		return null

	var resources = _find(player, [3, 3, 3])
	if not resources:
		return null

	self.pressed.connect(_pressed)

	return {
		resources = resources,
		diamonds = []
	}

func _pressed():
	if not _n_resources_selected(playerOwner, 1):
		return

	var card = playerOwner.selectedResources.pop_back()

	GameManager.graveyardResources.append(card.resourceValue)
	playerOwner.resourcesOnHand.erase(card)
	card.queue_free()

	# TODO: Let player choose resource
	playerOwner.selectedVirtualResources.append(0)
