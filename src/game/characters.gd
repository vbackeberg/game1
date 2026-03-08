class_name Characters
extends Object

static func get_cards():
	var cards = []
	for c in _cardTypes:
		for n in c[1]:
			cards.append(c[0])
	return cards

## The card scenes and how often they are present in the deck.
static var _cardTypes = [
	[preload("res://src/game/characters/actions_1_3_5_7.tscn"), 1],
	[preload("res://src/game/characters/actions_2_4_6_8.tscn"), 1],
	[preload("res://src/game/characters/ape_10.tscn"), 3],
	[preload("res://src/game/characters/bilbo_even.tscn"), 1],
	[preload("res://src/game/characters/bilbo_odd.tscn"), 1],
	[preload("res://src/game/characters/bombadil_7_7_8_8.tscn"), 2],
	[preload("res://src/game/characters/diamond_for_two.tscn"), 1],
	[preload("res://src/game/characters/diamonds_subtract.tscn"), 1],
	[preload("res://src/game/characters/discard_7.tscn"), 2],
	[preload("res://src/game/characters/dog_1_1_1_1.tscn"), 1],
	[preload("res://src/game/characters/dwarf_1.tscn"), 1],
	[preload("res://src/game/characters/dwarf_2.tscn"), 1],
	[preload("res://src/game/characters/dwarf_3.tscn"), 1],
	[preload("res://src/game/characters/dwarf_4.tscn"), 1],
	[preload("res://src/game/characters/dwarf_5.tscn"), 1],
	[preload("res://src/game/characters/dwarf_6.tscn"), 1],
	[preload("res://src/game/characters/dwarf_7.tscn"), 1],
	[preload("res://src/game/characters/eight_for_one.tscn"), 1],
	[preload("res://src/game/characters/ent_x_x_x_x.tscn"), 1],
	[preload("res://src/game/characters/exchange_street.tscn"), 1],
	[preload("res://src/game/characters/goblin_x_x.tscn"), 3],
	[preload("res://src/game/characters/kerberos_x_x_x.tscn"), 2],
	[preload("res://src/game/characters/lion_8_8_8_8.tscn"), 1],
	[preload("res://src/game/characters/mother_7_7_7_7.tscn"), 2],
	[preload("res://src/game/characters/neighbor_x_x_y_y.tscn"), 1],
	[preload("res://src/game/characters/neighbors_3_6.tscn"), 1],
	[preload("res://src/game/characters/neighbors_4_5.tscn"), 1],
	[preload("res://src/game/characters/steal_5_6_7.tscn"), 2],
	[preload("res://src/game/characters/peek_stack.tscn"), 1],
	[preload("res://src/game/characters/phoenix_1_2.tscn"), 1],
	[preload("res://src/game/characters/pipe_x_x_6_6.tscn"), 2],
	[preload("res://src/game/characters/pirate_2_2_2.tscn"), 1],
	[preload("res://src/game/characters/reaper_1_8.tscn"), 1],
	[preload("res://src/game/characters/redhood_4_5_6_7_8.tscn"), 1],
	[preload("res://src/game/characters/tarzan_20.tscn"), 1],
	[preload("res://src/game/characters/three_for_wildcard.tscn"), 1],
	[preload("res://src/game/characters/tomcat_3_4_5.tscn"), 1],
	[preload("res://src/game/characters/twins_8_8.tscn"), 2],
	[preload("res://src/game/characters/unicorn_1_2_3_4.tscn"), 1],
	[preload("res://src/game/characters/viking_6_6_8_8.tscn"), 2],
]
