class_name CardCharacter
extends TextureButton

var slot: int

## Returns the cards paid to buy this card or null if it could not be played.
var points: int
var diamonds: int
var asset_path: String
var backside := false
var playerOwner: Node2D

func _init(p_points, p_diamonds, p_asset_path) -> void:
	points = p_points
	diamonds = p_diamonds
	asset_path = "res://assets/characters/" + p_asset_path + ".png"

func _ready() -> void:
	var p = "res://assets/character_back.png" if backside else asset_path	
	texture_normal = load(p)
	scale = Vector2(128.0, 200.0) / texture_normal.get_size()
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

static func _includes(player: PlayerArea, requiredResources: Array[int], requiredDiamonds = 0) -> Variant:
	var paid = {
		resources = [],
		diamonds = []
		}

	while player.selectedVirtualResources.size() > 0:
		var value = player.selectedVirtualResources.pop_back()
		var idx = requiredResources.find(value)
		if idx == -1:
			return null
		else:
			requiredResources.remove_at(idx)
	
	while player.selectedResources.size() > 0:
		var card = player.selectedResources.pop_back()
		var idx = requiredResources.find(card.resourceValue)
		if idx == -1:
			return null
		else:
			requiredResources.remove_at(idx)
			paid.resources.append(card)


	while player.selectedDiamonds.size() > 0:
		requiredDiamonds -= 1
		paid.diamonds.append(player.selectedDiamonds.pop_back())


	if requiredDiamonds != 0 or requiredResources.size() > 0:
		return null

	return paid

static func _includes_either_or(player: PlayerArea, eitherRequired: Array[int], orRequired: Array[int]) -> Variant:
	var paid = _includes(player, eitherRequired, 0)
	if paid == null:
		paid = _includes(player, orRequired, 0)

	return paid

static func sums_up_to_s_using_exactly_n(player: PlayerArea, s: int, n: int) -> Variant:
	var paid = {
		resources = [],
		diamonds = []
		}

	while player.selectedVirtualResources.size() > 0:
		s -= player.selectedVirtualResources.pop_back()
		n -= 1

	while player.selectedResources.size() > 0:
		var card = player.selectedResources.pop_back()
		s -= card.value
		n -= 1
		paid.resources.append(card)

	if n != 0 or s != 0:
		return null

	return paid

static func _sums_up_to_s(player: PlayerArea, s: int) -> Variant:
	var paid = {
		resources = [],
		diamonds = []
		}
	
	while player.selectedVirtualResources.size() > 0:
		s -= player.selectedVirtualResources.pop_back()
	
	while player.selectedResources.size() > 0:
		var card = player.selectedResources.pop_back()
		s -= card.value
		paid.resources.append(card)

	if s != 0:
		return null
	
	return paid

## Checks if the required number of identical cards are paid.
## Example: For a pair required is 2.
## Returns null if the player selected too many or too little resources.
## Otherwise returns paid resources and diamonds.
static func _is_n_of_a_kind(player: PlayerArea, n: int) -> Variant:
	var paid = {
		resources = [],
		diamonds = []
	}
	
	var value: int

	while player.selectedVirtualResources.size() > 0:
		if value == null:
			value = player.selectedVirtualResources.pop_back()
			n -= 1
		else:
			var nextValue = player.selectedVirtualResources.pop_back()
			if value == nextValue:
				n -= 1
			else:
				return null
	
	while player.selectedResources.size() > 0:
		if value == null:
			var nextCard = player.selectedResources.pop_back()
			value = nextCard.resourceValue
			paid.resources.append(nextCard)
			n -= 1
		else:
			var nextCard = player.selectedResources.pop_back()
			value = nextCard.resourceValue
			if value == nextCard.resourceValue:
				paid.resources.append(nextCard)
				n -= 1
			else:
				return null

	if n != 0:
		return null
	else:
		return paid


static func _is_n_of_two_kinds(player: PlayerArea, n: int) -> Variant:
	var firstPair = _is_n_of_a_kind(player, n)
	var secondPair = _is_n_of_a_kind(player, n)

	if firstPair == null or secondPair == null:
		return null

	var paid = {
		resources = [],
		diamonds = []
	}

	paid.resources.append_array(firstPair.resources)
	paid.resources.append_array(secondPair.resources)

	return paid

static func _is_three_odd_or_even(player: PlayerArea, should_be_even: bool) -> Variant:
	var paid = {
		resources = [],
		diamonds = []
	}
	var n = 3

	while player.selectedVirtualResources.size() > 0:
		var value = player.selectedVirtualResources.pop_back()
		if (value % 2 == 0) == should_be_even:
			n -= 1
		else:
			return null

	while player.selectedResources.size() > 0:
		var value = player.selectedResources.pop_back()
		if (value % 2 == 0) == should_be_even:
			n -= 1
		else:
			return null

	if n != 0:
		return null
	else:
		return paid

static func _is_street_of_n(player: PlayerArea, n: int) -> Variant:
	var paid = {resources = [], diamonds = []}
	
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
	
	paid.resources.append_array(player.selectedResources)
	return paid
