class_name Characters
extends Object


static func load_cards() -> Array[CardCharacter]:
	return [
		CardCharacter.new(
			func(player, card): return _includes(player, [2, 2, 2], 1) if _is_owner(player, card) else null,
			3,
			0,
			"pirate-2-2-2"
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [1, 1]) if _is_owner(player, card) else null,
			1,
			0,
			"dwarf-1",
			func(_player): pass ,
			func(player): player.selectedVirtualResources.append(1)
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [2, 2]) if _is_owner(player, card) else null,
			1,
			0,
			"dwarf-2",
			func(_player): pass ,
			func(player): player.selectedVirtualResources.append(2)
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [3, 3]) if _is_owner(player, card) else null,
			1,
			0,
			"dwarf-3",
			func(_player): pass ,
			func(player): player.selectedVirtualResources.append(3)
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [4, 4]) if _is_owner(player, card) else null,
			1,
			0,
			"dwarf-4",
			func(_player): pass ,
			func(player): player.selectedVirtualResources.append(4)
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [5, 5]) if _is_owner(player, card) else null,
			1,
			0,
			"dwarf-5",
			func(_player): pass ,
			func(player): player.selectedVirtualResources.append(5)
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [6, 6], 0) if _is_owner(player, card) else null,
			1,
			0,
			"dwarf-6",
			func(_player): pass ,
			func(player): player.selectedVirtualResources.append(6)
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [7, 7], 0) if _is_owner(player, card) else null,
			1,
			0,
			"dwarf-7",
			func(_player): pass ,
			func(player): player.selectedVirtualResources.append(7)
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [1, 1, 1, 1], 0) if _is_owner(player, card) else null,
			1,
			0,
			"dog-1-1-1-1",
			func(_player): pass ,
			func(player): player.selectedVirtualResources.append("*") # TODO placeholder
		),
		CardCharacter.new(
			func(player): return _includes_either_or(player, [3, 3, 3], [6, 6, 6]),
			3,
			0,
			"neighbors-3-6"
		),
		CardCharacter.new(
			func(player): return _includes_either_or(player, [4, 4, 4], [5, 5, 5]),
			3,
			0,
			"neighbors-4-5"
		),
		CardCharacter.new(
			func(player, card): return _is_n_of_a_kind(player, 2) if _is_owner(player, card) else null,
			1,
			0,
			"goblin-x-x"
		),
		CardCharacter.new(
			func(player, card): return _is_n_of_a_kind(player, 2) if _is_owner(player, card) else null,
			1,
			0,
			"goblin-x-x"
		),
		CardCharacter.new(
			func(player, card): return _is_n_of_a_kind(player, 2) if _is_owner(player, card) else null,
			1,
			0,
			"goblin-x-x"
		),
		CardCharacter.new(
			func(player, card): return _is_n_of_a_kind(player, 3) if _is_owner(player, card) else null,
			2,
			0,
			"kerberos-x-x-x"
		),
		CardCharacter.new(
			func(player, card): return _is_n_of_a_kind(player, 3) if _is_owner(player, card) else null,
			2,
			0,
			"kerberos-x-x-x"
		),
		CardCharacter.new(
			func(player, card): return _is_n_of_a_kind(player, 4) if _is_owner(player, card) else null,
			3,
			0,
			"ent-x-x-x-x"
		),
		
		CardCharacter.new(
			func(player, card): return _is_n_of_two_kinds(player, 2) if _is_owner(player, card) else null,
			2,
			0,
			"neighbor-x-x-y-y"
		),
		CardCharacter.new(
			func(player, card): return _is_three_odd_or_even(player, true) if _is_owner(player, card) else null,
			1,
			1,
			"bilbo-even"
		),
		CardCharacter.new(
			func(player, card): return _is_three_odd_or_even(player, false) if _is_owner(player, card) else null,
			1,
			1,
			"bilbo-odd"
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [6, 6, 8, 8]) if _is_owner(player, card) else null,
			2,
			1,
			"pipe-x-x-6-6"
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [6, 6, 8, 8]) if _is_owner(player, card) else null,
			2,
			1,
			"pipe-x-x-6-6"
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [6, 6, 8, 8]) if _is_owner(player, card) else null,
			3,
			0,
			"viking-6-6-8-8"
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [6, 6, 8, 8]) if _is_owner(player, card) else null,
			3,
			0,
			"viking-6-6-8-8"
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [7, 7, 8, 8]) if _is_owner(player, card) else null,
			3,
			1,
			"bombadil-7-7-8-8"
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [7, 7, 8, 8]) if _is_owner(player, card) else null,
			3,
			1,
			"bombadil-7-7-8-8"
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [8, 8]) if _is_owner(player, card) else null,
			2,
			0,
			"twins-8-8"
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [8, 8]) if _is_owner(player, card) else null,
			2,
			0,
			"twins-8-8"
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [1, 2, 3, 4]) if _is_owner(player, card) else null,
			1,
			2,
			"unicorn-1-2-3-4"
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [7, 7, 7, 7]) if _is_owner(player, card) else null,
			4,
			0,
			"mother-7-7-7-7"
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [7, 7, 7, 7]) if _is_owner(player, card) else null,
			4,
			0,
			"mother-7-7-7-7"
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [8, 8, 8, 8]) if _is_owner(player, card) else null,
			5,
			0,
			"lion-8-8-8-8"
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [1, 2]) if _is_owner(player, card) else null,
			0,
			0,
			"phoenix-1-2",
			func(_player): pass ,
			func(player): player.selectedVirtualResources.append(8)
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [1, 2]) if _is_owner(player, card) else null,
			0,
			0,
			"phoenix-1-2",
			func(_player): pass ,
			func(player): player.selectedVirtualResources.append(8)
		),
		CardCharacter.new(
			func(player, card): return _sums_up_to_s_using_exactly_n(player, 20, 3) if _is_owner(player, card) else null,
			2,
			0,
			"tarzan-20"
		),
		CardCharacter.new(
			func(player, card): return _sums_up_to_s(player, 10) if _is_owner(player, card) else null,
			1,
			0,
			"ape-10",
			func(player): player.resourceCapacity += 1
		),
		CardCharacter.new(
			func(player, card): return _sums_up_to_s(player, 10) if _is_owner(player, card) else null,
			1,
			0,
			"ape-10",
			func(player): player.resourceCapacity += 1
		),
		CardCharacter.new(
			func(player, card): return _sums_up_to_s(player, 10) if _is_owner(player, card) else null,
			1,
			0,
			"ape-10",
			func(player): player.resourceCapacity += 1
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [1, 3, 5, 7]) if _is_owner(player, card) else null,
			2,
			0,
			"actions-1-3-5-7",
			func(player): player.actionsLeft += 1
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [2, 4, 6, 8]) if _is_owner(player, card) else null,
			2,
			0,
			"actions-2-4-6-8",
			func(player): player.actionsLeft += 1
		),
		CardCharacter.new(
			func(player, card): return _includes(player, [4, 5, 6, 7, 8]) if _is_owner(player, card) else null,
			1,
			0,
			"redhood-4-5-6-7-8",
			func(player): player.actionsPerTurn += 1
		),
		),
	]

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

static func _sums_up_to_s_using_exactly_n(player: PlayerArea, s: int, n: int) -> Variant:
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


static func _is_owner(player: Node2D, card: CardCharacter) -> bool:
	return player == card.playerOwner

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
