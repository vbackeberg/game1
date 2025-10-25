class_name Neighbors
extends CardCharacter

var numbers: Array[int]

func _init():
	super._init(3, 0, "neighbors-{0}-{1}".format(numbers))

func buy(player: PlayerArea) -> Variant:
	if _is_owner(player):
		var paid = _includes_either_or(player, [numbers[0], numbers[0], numbers[0]], [numbers[1], numbers[1], numbers[1]])
		if paid:
			return paid
	return null
