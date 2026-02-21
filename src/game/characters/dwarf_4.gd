class_name DwarfFour
extends CardCharacter

var resourceValue := 4

func _init():
	points = 1
	
	$ActivatedOverlay/ActivatedLabel.text = str(resourceValue)

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player) or not _n_resources_selected(player, 2):
		return false

	if not _has_selected(player, [4, 4]):
		return false

	self.pressed.connect(_on_pressed)

	return true

func _on_pressed():
	var idx = playerOwner.selectedVirtualResources.find(self)
	if idx == -1:
		playerOwner.selectedVirtualResources.append(self)
		$ActivatedOverlay.visible = true
	else:
		playerOwner.selectedVirtualResources.remove_at(idx)
		$ActivatedOverlay.visible = false
