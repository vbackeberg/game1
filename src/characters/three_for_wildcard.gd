class_name ThreeForWildcard
extends CardCharacter

var resourceValue: int

func _init():
	points = 1
	asset_path = "res://assets/characters/three-for-wildcard.png"

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player) or not _has_selected(player, [3, 3, 3]):
		return false

	self.pressed.connect(_on_pressed)

	return true

func _on_pressed():
	if not _n_resources_selected(playerOwner, 1):
		return

	var card = playerOwner.selectedResources.pop_back()

	GameManager.graveyardResources.append(card.resourceValue)
	playerOwner.resourcesOnHand.erase(card)
	card.queue_free()

	# TODO: Let player choose resource
	playerOwner.selectedVirtualResources.append(0)
