extends Node

var playerArea: Node2D
var middleArea: Node2D
var current_view: String = "middle" # Can be "middle" or "hand"
var actionsLeft: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerArea = $PlayerArea # Make it accessible from middle area.
	middleArea = $MiddleArea
	
	$PlayerArea.visible = false
	actionsLeft = 3
	$PlayerArea.action_used.connect(_on_action_used)
	$MiddleArea.action_used.connect(_on_action_used)

func _input(event):
	if event.is_action_pressed("ui_accept"): # Space bar
		toggle_view()

func toggle_view():
	if current_view == "middle":
		$MiddleArea.visible = false
		$PlayerArea.visible = true
		current_view = "hand"
	else:
		$MiddleArea.visible = true
		$PlayerArea.visible = false
		current_view = "middle"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_action_used():
	actionsLeft -= 1
	if actionsLeft == 0:
		print("All actions used. Next player's turn.")
