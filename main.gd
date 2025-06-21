extends Node

var playerArea: Node2D
var middleArea: Node2D
var middleVisible: bool
var actionsLeft: int

var currentPlayer: int
var players: Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	middleArea = $MiddleArea
	$MiddleArea.action_used.connect(_on_action_used)
	middleVisible = true

	players = [$PlayerArea, $PlayerArea2, $PlayerArea3, $PlayerArea4, $PlayerArea5, $PlayerArea6]
	currentPlayer = 0
	players[currentPlayer].visible = false
	players[currentPlayer].action_used.connect(_on_action_used)
	actionsLeft = 3

func _input(event):
	if event.is_action_pressed("ui_accept"): # Space bar
		toggle_view()

func toggle_view():
	if middleVisible == true:
		$MiddleArea.visible = false
		players[currentPlayer].visible = true
		middleVisible = false
	else:
		$MiddleArea.visible = true
		players[currentPlayer].visible = false
		middleVisible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_action_used():
	actionsLeft -= 1
	if actionsLeft == 0:
		print("All actions used. Next player's turn.")
		currentPlayer = (currentPlayer + 1) % players.size()
		actionsLeft = 3
