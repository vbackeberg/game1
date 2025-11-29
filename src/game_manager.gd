extends Node


func _ready() -> void:
	players = [$PlayerArea, $PlayerArea2]

func draw_diamond():
	currentPlayer.draw_diamond()