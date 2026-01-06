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

## Turns a selected 3 into a wildcard
func _on_pressed():
	if playerOwner.selectedVirtualResources.has(self):
		playerOwner.selectedVirtualResources.erase(self)
		$ActivatedOverlay.visible = false
	else:
		if not _n_resources_selected(playerOwner, 1):
			return

		var card = playerOwner.selectedResources.pop_back()

		GameManager.graveyardResources.append(card.resourceValue)
		playerOwner.resourcesOnHand.erase(card)
		card.queue_free()
		playerOwner.reorder_resource_cards()

		WildcardSelect.visible = true
		WildcardSelect.number_selected.connect(_on_number_selected)


func _on_number_selected(number: int):
	WildcardSelect.number_selected.disconnect(_on_number_selected)
	WildcardSelect.visible = false
	resourceValue = number
	playerOwner.selectedVirtualResources.append(self)
	$ActivatedOverlay.visible = true
	$ActivatedOverlay/ActivatedLabel.text = str(resourceValue)

