class_name ReaperOneEight
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/reaper-1-8.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _n_resources_selected(player, 2):
		return null

	var resources = _find(player, [1,8])
	if not resources:
		return null
	
	self.pressed.connect(_pressed)

	return {
		resources = resources,
		diamonds = []
	}


func _pressed():
	var cntResources = playerOwner.resourcesOnHand.size()

	for r in playerOwner.resourcesOnHand:
		get_parent().on_resource_spent(r.resourceValue)
		r.queue_free()
	playerOwner.resourcesOnHand.clear()

	for n in cntResources:
		var card = GameManager.draw_resource()
		playerOwner.add_resource(card)
