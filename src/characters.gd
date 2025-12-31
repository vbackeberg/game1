class_name Characters
extends Object

static func get_cards():
	var cards = []
	for c in _cardTypes:
		for n in c[1]:
			cards.append(c[0])
	return cards



static var _cardTypes = [
	[preload("res://src/characters/actions_1_3_5_7.tscn"), 1],
	[preload("res://src/characters/actions_2_4_6_8.tscn"), 1],
	[preload("res://src/characters/ape_10.tscn"), 3],
	[preload("res://src/characters/bilbo_even.tscn"), 1],
	[preload("res://src/characters/bilbo_odd.tscn"), 1],
	[preload("res://src/characters/bombadil_7_7_8_8.tscn"), 2],
	[preload("res://src/characters/diamond_for_two.tscn"), 1],
	[preload("res://src/characters/diamonds_subtract.tscn"), 1],
	[preload("res://src/characters/discard_7.tscn"), 2],
	[preload("res://src/characters/dog_1_1_1_1.tscn"), 1],
	[preload("res://src/characters/dwarf_1.tscn"), 1],
	[preload("res://src/characters/dwarf_2.tscn"), 1],
	[preload("res://src/characters/dwarf_3.tscn"), 1],
	[preload("res://src/characters/dwarf_4.tscn"), 1],
	[preload("res://src/characters/dwarf_5.tscn"), 1],
	[preload("res://src/characters/dwarf_6.tscn"), 1],
	[preload("res://src/characters/dwarf_7.tscn"), 1],
	[preload("res://src/characters/eight_for_one.tscn"), 1],
	[preload("res://src/characters/ent_x_x_x_x.tscn"), 1],
	[preload("res://src/characters/exchange_street.tscn"), 1],
	[preload("res://src/characters/goblin_x_x.tscn"), 3],
	[preload("res://src/characters/kerberos_x_x_x.tscn"), 2],
	[preload("res://src/characters/lion_8_8_8_8.tscn"), 1],
	[preload("res://src/characters/mother_7_7_7_7.tscn"), 2],
	[preload("res://src/characters/neighbor_x_x_y_y.tscn"), 1],
	[preload("res://src/characters/neighbors_3_6.tscn"), 1],
	[preload("res://src/characters/neighbors_4_5.tscn"), 1],
	[preload("res://src/characters/peek_5_6_7.tscn"), 2],
	[preload("res://src/characters/peek_stack.tscn"), 1],
	[preload("res://src/characters/phoenix_1_2.tscn"), 1],
	[preload("res://src/characters/pipe_x_x_6_6.tscn"), 2],
	[preload("res://src/characters/pirate_2_2_2.tscn"), 1],
	[preload("res://src/characters/reaper_1_8.tscn"), 1],
	[preload("res://src/characters/redhood_4_5_6_7_8.tscn"), 1],
	[preload("res://src/characters/tarzan_20.tscn"), 1],
	[preload("res://src/characters/three_for_wildcard.tscn"), 1],
	[preload("res://src/characters/tomcat_3_4_5.tscn"), 1],
	[preload("res://src/characters/twins_8_8.tscn"), 2],
	[preload("res://src/characters/unicorn_1_2_3_4.tscn"), 1],
	[preload("res://src/characters/viking_6_6_8_8.tscn"), 2],
]
