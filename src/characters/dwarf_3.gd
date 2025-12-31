class_name DwarfThree
extends CardCharacter

var resourceValue := 3

func _init():
	points = 1
	asset_path = "res://assets/characters/dwarf-3.png"
	$ActivatedOverlay/ActivatedLabel.text = str(resourceValue)

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 2):
		return null

	var resources = _find(player, [3, 3])
	if not resources:
		return null

	self.pressed.connect(_on_pressed)

	return {
		resources = resources,
		diamonds = []
	}

func _on_pressed():
	var idx = playerOwner.selectedVirtualResources.find(self)
	if idx == -1:
		playerOwner.selectedVirtualResources.append(self)
		$ActivatedOverlay.visible = true
	else:
		playerOwner.selectedVirtualResources.remove_at(idx)
		$ActivatedOverlay.visible = false
