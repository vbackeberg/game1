class_name DwarfSeven
extends CardCharacter

var resourceValue := 7

func _init():
	points = 1
	asset_path = "res://assets/characters/dwarf-7.png"
	$ActivatedOverlay/ActivatedLabel.text = str(resourceValue)

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 2):
		return null

	if not _find(player, [7, 7]):
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
