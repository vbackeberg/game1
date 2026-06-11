class_name Resources
extends Object

static func get_cards():
	var cards = []
	for c in _cardTypes:
		for n in c[1]:
			cards.append(c[0])
	return cards

## The card scenes and how often they are present in the deck.
static var _cardTypes = [
	[preload("res://src/game/resources/1.tscn"), 7],
	[preload("res://src/game/resources/2.tscn"), 7],
	[preload("res://src/game/resources/3.tscn"), 7],
	[preload("res://src/game/resources/4.tscn"), 7],
	[preload("res://src/game/resources/5.tscn"), 7],
	[preload("res://src/game/resources/6.tscn"), 7],
	[preload("res://src/game/resources/7.tscn"), 7],
	[preload("res://src/game/resources/8.tscn"), 7],
]
