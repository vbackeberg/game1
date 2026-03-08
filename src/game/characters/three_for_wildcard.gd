class_name ThreeForWildcard
extends CardCharacter

var resourceValue: int

## Keeps the reference to the selected resource card for restoring it if player deselects effect.
var selectedResource: CardResource

func _init():
	points = 1
	

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player) or not _has_selected(player, [3, 3, 3]):
		return false

	self.pressed.connect(_on_pressed)

	return true

## Turns a selected 3 into a wildcard
func _on_pressed():
	if playerOwner.selectedVirtualResources.has(self):
		playerOwner.selectedVirtualResources.erase(self)

		selectedResource.visible = true
		playerOwner.resourcesOnHand.append(selectedResource)
		playerOwner.reorder_resource_cards()
		playerOwner.character_bought.disconnect(_on_character_bought)

		$ActivatedOverlay.visible = false
	else:
		if playerOwner.selectedResources.size() != 1 or playerOwner.selectedResources[0].resourceValue != 3:
			print("Error: No resources of value 3 selected")
			return

		playerOwner.character_bought.connect(_on_character_bought)

		var card = playerOwner.selectedResources.pop_back()
		card.deselect()
		card.visible = false
		playerOwner.resourcesOnHand.erase(card)
		playerOwner.reorder_resource_cards()
		selectedResource = card

		WildcardSelect.visible = true
		WildcardSelect.number_selected.connect(_on_number_selected)


func _on_number_selected(number: int):
	WildcardSelect.number_selected.disconnect(_on_number_selected)
	WildcardSelect.visible = false
	resourceValue = number
	playerOwner.selectedVirtualResources.append(self)
	$ActivatedOverlay.visible = true
	$ActivatedOverlay/ActivatedLabel.text = str(resourceValue)


func _on_character_bought():
	GameManager.graveyardResources.append(selectedResource.resourceValue)
	selectedResource.queue_free()
	playerOwner.character_bought.disconnect(_on_character_bought)
