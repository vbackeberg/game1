class_name PhoenixOneTwo
extends CardCharacter

var resourceValue := 8

func _init():
	points = 0
	
	$ActivatedOverlay/ActivatedLabel.text = str(resourceValue)

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player) or not _has_selected(player, [1, 2]):
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
