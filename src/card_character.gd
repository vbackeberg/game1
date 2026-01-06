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

static func _has_selected(player: PlayerArea, given: Array[int]) -> bool:
	var resources = []
	resources.append_array(player.selectedResources.duplicate())
	resources.append_array(player.selectedVirtualResources.duplicate())
	var indices = _find(resources, given)
	return indices.size() != 0

static func _has_n_of_same_kind(player: PlayerArea, n: int) -> bool:
	var resources = []
	resources.append_array(player.selectedResources.duplicate())
	resources.append_array(player.selectedVirtualResources.duplicate())
	var indices = _find_n_of_same_kind(resources, n)
	return indices.size() != 0

## Returns the indices of the found resources or an empty array if not all found
static func _find(resources: Array, given: Array[int]) -> Array:
	var indices = []

	for g in given:
		var idx = resources.find_custom(func(r): return r.resourceValue == g)
		if idx != -1:
			resources.remove_at(idx)
			indices.append(idx)
		else:
			return []
	return indices

static func _find_n_of_same_kind(resources: Array, n: int) -> Array:
	for i in range(1, 8):
		var g = []
		g.resize(n)
		g.fill(i)
		var indices = _find(resources, g)
		if indices.size() == n:
			return indices
	return []

static func _has_either_or(player: PlayerArea, eitherV: Array[int], orV: Array[int]) -> bool:
	var resources = []
	resources.append_array(player.selectedResources.duplicate())
	resources.append_array(player.selectedVirtualResources.duplicate())

	if _find(resources, eitherV).size() != 0 or _find(resources, orV).size() != 0:
		return true

	return false
