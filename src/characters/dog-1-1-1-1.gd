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
	$WildcardSelect.visible = true
	$WildcardSelect.number_selected.connect(_on_number_selected)

func _on_number_selected(number: int):
	$WildcardSelect.number_selected.disconnect(_on_number_selected)
	$WildcardSelect.visible = false

	playerOwner.selectedVirtualResources.append(number)

	var virtual_resource = load("res://src/virtual_resource.tscn").instantiate() as TextureButton
	virtual_resource.custom_minimum_size = Vector2(128.0, 200.0)
	virtual_resource.texture_normal = load("res://assets/resource" + str(number) + ".png")
	virtual_resource.position.x = self.position.x
	virtual_resource.position.y = self.position.y + 100.0
	virtual_resource.pressed.connect(_on_virtual_resource_pressed.bind(virtual_resource))

	add_child(virtual_resource)

func _on_virtual_resource_pressed(virtual_resource: TextureButton):
	virtual_resource.queue_free()
	playerOwner.selectedVirtualResources.erase(virtual_resource.resourceValue)