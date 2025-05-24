extends Node

var playersHand: Node2D
var current_view: String = "middle"  # Can be "middle" or "hand"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playersHand = $PlayersHand
	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):  # Space bar
		toggle_view()

func toggle_view():
	if current_view == "middle":
		$MiddleArea.visible = false
		$PlayersHand.visible = true
		current_view = "hand"
	else:
		$MiddleArea.visible = true
		$PlayersHand.visible = false
		current_view = "middle"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
