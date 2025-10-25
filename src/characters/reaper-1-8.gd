class_name ReaperOneEight
extends CardCharacter

func _init():
	super._init(1, 0, "reaper-1-8")

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes(player, [1, 8])
		if paid:
			self.pressed.connect(_pressed)
			return paid
			
	return null

func on_pressed():
	var cntResources = playerOwner.resourcesOnHand.size()

	for r in playerOwner.resourcesOnHand:
		r.queue_free()
	playerOwner.resourcesOnHand.clear()

	for n in range(cntResources):
		var card = MiddleArea.draw_resource()
		playerOwner.add_resource(card)