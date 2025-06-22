extends Node

var playerArea: Node2D
var middleArea: Node2D
var middleVisible: bool

var currentPlayerIdx: int
var currentPlayer: Node2D
var players: Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	middleArea = $MiddleArea
	$MiddleArea.action_used.connect(_on_action_used)
	middleVisible = true

	players = [$PlayerArea, $PlayerArea2, $PlayerArea3, $PlayerArea4, $PlayerArea5, $PlayerArea6]
	currentPlayerIdx = 0
	currentPlayer = players[currentPlayerIdx]
	currentPlayer.actionsLeft = 3
	currentPlayer.action_used.connect(_on_action_used)
	$ActionsLeftLabel.text = str(currentPlayer.actionsLeft)

func _input(event):
	if event.is_action_pressed("ui_accept"): # Space bar
		toggle_view()

func toggle_view():
	if middleVisible == true:
		$MiddleArea.visible = false
		currentPlayer.visible = true
		middleVisible = false
	else:
		$MiddleArea.visible = true
		currentPlayer.visible = false
		middleVisible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_action_used():
	currentPlayer.actionsLeft -= 1

	if currentPlayer.actionsLeft == 0:
		print("All actions used. Next player's turn.")
		_next_player()
	
	$ActionsLeftLabel.text = str(currentPlayer.actionsLeft)

func _next_player():
	currentPlayerIdx = (currentPlayerIdx + 1) % players.size()
	currentPlayer = players[currentPlayerIdx]
	currentPlayer.actionsLeft = 3
