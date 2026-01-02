class_name CardCharacter
extends TextureButton

var slot: int
var points: int
var asset_path:= "res://assets/character_back.png"
var backside := false
var playerOwner: PlayerArea
var scene:= preload("res://src/card_character.tscn")

func select(forDiscard := false):
	self.modulate = Color(1.2, 0.8, 0.8) if forDiscard else Color(1.2, 1.2, 0.8) # Yellow and Red tint

func deselect():
	self.modulate = Color(1, 1, 1) # Reset to normal color

## Override to set a permanent effect
func activate_permanent_effect():
	pass

func _is_owner(player: PlayerArea):
	return player == playerOwner

static func concat(arr: Array) -> String:
	var result = ""
	for num in arr:
		result += str(num)
	return result

# Buy functions

static func _sums_up_to_s_using_exactly_n(player: PlayerArea, s: int, n: int) -> bool:
	var resources = []
	resources.append_array(player.selectedResources)
	resources.append_array(player.selectedVirtualResources)

	while resources.size() > 0:
		var card = resources.pop_back()
		s -= card.resourceValue
		n -= 1

	if n != 0 or s != 0:
		return false

	return true

static func _sums_up_to_s(player: PlayerArea, s: int) -> bool:
	var resources = []
	resources.append_array(player.selectedResources)
	resources.append_array(player.selectedVirtualResources)

	while resources.size() > 0:
		var card = resources.pop_back()
		s -= card.resourceValue
	
	if s != 0:
		return false
	
	return true

static func _n_resources_selected(player: PlayerArea, n: int):
	return player.selectedVirtualResources.size() + player.selectedResources.size() == n

static func _is_three_odd_or_even(player: PlayerArea, should_be_even: bool) -> bool:
	var resources = []
	resources.append_array(player.selectedResources)
	resources.append_array(player.selectedVirtualResources)

	var n = 3

	while resources.size() > 0:
		var card = resources.pop_back()
		if (card.resourceValue % 2 == 0) == should_be_even:
			n -= 1
		else:
			return false

	if n != 0:
		return false
	return true

static func _is_street_of_n(player: PlayerArea, n: int) -> bool:
	var resources = []
	resources.append_array(player.selectedResources)
	resources.append_array(player.selectedVirtualResources)

	if resources.size() != n:
		return false

	resources.sort_custom(func(a, b): return a.resourceValue - b.resourceValue)
	
	for i in range(1, n):
		if resources[i].resourceValue != resources[i - 1].resourceValue + 1:
			return false

	return true

static func _find(player: PlayerArea, given: Array[int]) -> bool:
	var resources = []
	resources.append_array(player.selectedResources.duplicate())
	resources.append_array(player.selectedVirtualResources.duplicate())

	if resources.size() != given.size():
		return false

	for g in given:
		var idx = resources.find_custom(func(r): return r.resourceValue == g)
		if idx != -1:
			resources.remove_at(idx)
		else:
			return false

	return true

static func _find_n_of_same_kind(player: PlayerArea, n: int):
	for i in range(1, 8):
		var g = []
		g.resize(n)
		g.fill(i)
		if _find(player, g):
			return true
	
	return false

static func _find_either_or(player: PlayerArea, eitherV: Array[int], orV: Array[int]) -> bool:
	if _find(player, eitherV) or _find(player, orV):
		return true
	return false
	
