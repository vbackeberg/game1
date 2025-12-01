class_name CardCharacter
extends TextureButton

var slot: int

var points: int
var asset_path: String
var backside := false
var playerOwner: PlayerArea

func _ready() -> void:
	var p = "res://assets/character_back.png" if backside else asset_path
	self.texture_normal = load(p)
	scale = Vector2(128.0, 200.0) / self.texture_normal.get_size()
	pass

func select(forDiscard := false):
	self.modulate = Color(1.2, 0.8, 0.8) if forDiscard else Color(1.2, 1.2, 0.8) # Yellow and Red tint

func deselect():
	self.modulate = Color(1, 1, 1) # Reset to normal color

static func concat(arr: Array) -> String:
	var result = ""
	for num in arr:
		result += str(num)
	return result

func _is_owner(player: PlayerArea):
	return player == playerOwner


# Buy functions

static func _sums_up_to_s_using_exactly_n(player: PlayerArea, s: int, n: int) -> Variant:
	var resources = []

	while player.selectedVirtualResources.size() > 0:
		s -= player.selectedVirtualResources.pop_back()
		n -= 1

	while player.selectedResources.size() > 0:
		var card = player.selectedResources.pop_back()
		s -= card.resourceValue
		n -= 1
		resources.append(card)

	if n != 0 or s != 0:
		return null

	return resources

static func _sums_up_to_s(player: PlayerArea, s: int) -> Variant:
	var resources = []
	
	while player.selectedVirtualResources.size() > 0:
		s -= player.selectedVirtualResources.pop_back()
	
	while player.selectedResources.size() > 0:
		var card = player.selectedResources.pop_back()
		s -= card.resourceValue
		resources.append(card)

	if s != 0:
		return null
	
	return resources

static func _n_resources_selected(player: PlayerArea, n: int):
	return player.selectedVirtualResources.size() + player.selectedResources.size() != n

static func _is_three_odd_or_even(player: PlayerArea, should_be_even: bool) -> Variant:
	var resources = []
	var n = 3

	while player.selectedVirtualResources.size() > 0:
		var value = player.selectedVirtualResources.pop_back()
		if (value % 2 == 0) == should_be_even:
			n -= 1
		else:
			return null

	while player.selectedResources.size() > 0:
		var card = player.selectedResources.pop_back()
		if (card.resourceValue % 2 == 0) == should_be_even:
			resources.append(card)
			n -= 1
		else:
			return null

	if n != 0:
		return null
	else:
		return resources

static func _is_street_of_n(player: PlayerArea, n: int) -> Variant:
	var resources = []
	
	var values: Array[int] = []
	values.append_array(player.selectedVirtualResources)
	for card in player.selectedResources:
		values.append(card.resourceValue)
	values.sort()
	
	if values.size() != n:
		return null
	
	for i in range(1, n):
		if values[i] != values[i - 1] + 1:
			return null
	
	resources.append_array(player.selectedResources)
	return resources

static func _find(player: PlayerArea, given: Array[int]) -> Variant:
	var resources = []
	for g in given:
		var idx = player.selectedVirtualResources.find(g)
		if idx != -1:
			player.selectedVirtualResources.remove_at(idx)
		else:
			idx = player.selectedResources.find(g)
			if idx != -1:
				resources.append(player.selectedResources.pop_at(idx))
			else:
				return null

	return resources

static func _find_n_of_same_kind(player: PlayerArea, n: int):
	for i in range(1, 8):
		var g = []
		g.resize(n)
		g.fill(i)
		var resources = _find(player, g)
		if resources:
			return resources
	
	return null

static func _find_either_or(player: PlayerArea, eitherV: Array[int], orV: Array[int]) -> Variant:
	var indicesVirtualResources = []
	var indicesResources = []

	var resources = []

	for e in eitherV:
		var idx = player.selectedVirtualResources.find(e)
		if idx != -1:
			indicesVirtualResources.append(idx)
		else:
			idx = player.selectedResources.find(e)
			if idx != -1:
				indicesResources.append(idx)
			else:
				break
		
	if indicesVirtualResources.size() + indicesVirtualResources.size() == 3:
		for idx in indicesVirtualResources:
			player.selectedVirtualResources.remove_at(idx)
		for idx in indicesResources:
			resources.append(player.selectedResources.pop_at(idx))
		return resources

	for o in orV:
		var idx = player.selectedVirtualResources.find(o)
		if idx != -1:
			indicesVirtualResources.append(idx)
		else:
			idx = player.selectedResources.find(o)
			if idx != -1:
				indicesResources.append(idx)
			else:
				return null

	for idx in indicesVirtualResources:
		player.selectedVirtualResources.remove_at(idx)
	for idx in indicesResources:
		resources.append(player.selectedResources.pop_at(idx))
	return resources
	
