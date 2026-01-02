class_name RedhoodFourFiveSixSevenEight
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/redhood-4-5-6-7-8.png"

func buy(player: PlayerArea) -> Variant:
	if not _is_owner(player) or not _find(player, [4, 5, 6, 7, 8]):
		return false
		
	_immediate_effect()
	
	return true

func _immediate_effect():
	playerOwner.actionsPerTurn += 1
