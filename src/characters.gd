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
			func(player):
				var paid = _includes(player, [3, 3, 3], 0)
				if paid == null:
					paid = _includes(player, [6, 6, 6], 0)
				return paid,
			3,
			0,
			"neighbors-3-6"
		),
		CardCharacter.new(
			func(player):
				var paid = _includes(player, [4, 4, 4], 0)
				if paid == null:
					paid = _includes(player, [5, 5, 5], 0)
				return paid,
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
	]

static func _includes(player: PlayerArea, requiredResources: Array[int], requiredDiamonds: int) -> Variant:
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
