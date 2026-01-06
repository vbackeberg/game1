class_name TomcatThreeFourFive
extends CardCharacter

func _init():
	points = 1
	asset_path = "res://assets/characters/tomcat-3-4-5.png"

func buy(player: PlayerArea) -> bool:
	if not _is_owner(player) or not _has_selected(player, [4, 5, 6]):
		return false

	_immediate_effect()

	return true

func _immediate_effect():
	pass # TODO: take one of payed cards back
