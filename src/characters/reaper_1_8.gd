class_name ReaperOneEight
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/reaper-1-8.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _find(player, [1, 8]):
		return false
	
	self.pressed.connect(_on_pressed)

	return true


# TODO in After End Phase
func _on_pressed():
	var cntResources = playerOwner.resourcesOnHand.size()

	for r in playerOwner.resourcesOnHand:
		GameManager.graveyardResources.append(r.resourceValue)
		r.queue_free()
	playerOwner.resourcesOnHand.clear()

	for n in cntResources:
		var card = GameManager.draw_resource()
		playerOwner.add_resource(card)
