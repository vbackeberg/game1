class_name DogOneOneOneOne
extends CardCharacter

var resourceValue: int

func _init():
	points = 0
	asset_path = "res://assets/characters/dog-1-1-1-1.png"

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player):
		return false

	if not _has_selected(player, [1, 1, 1, 1]):
		return false
		
	self.pressed.connect(_on_pressed)

	return true

## Displays a picker that sets the resource value
func _on_pressed():
	var idx = playerOwner.selectedVirtualResources.find(self)
	if idx == -1:
		WildcardSelect.visible = true
		WildcardSelect.number_selected.connect(_on_number_selected)

	else:
		playerOwner.selectedVirtualResources.remove_at(idx)
		$ActivatedOverlay.visible = false


func _on_number_selected(number: int):
	WildcardSelect.number_selected.disconnect(_on_number_selected)
	WildcardSelect.visible = false
	resourceValue = number
	playerOwner.selectedVirtualResources.append(self)
	$ActivatedOverlay.visible = true
	$ActivatedOverlay/ActivatedLabel.text = str(resourceValue)
