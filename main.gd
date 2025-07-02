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
	middleVisible = true

	players = [$PlayerArea, $PlayerArea2]
	currentPlayerIdx = 0
	currentPlayer = players[currentPlayerIdx]
	currentPlayer.actionsLeft = 3
	$ActionsLeftLabel.text = str(currentPlayer.actionsLeft)
	$CurrentPlayerLabel.text = "Player " + str(currentPlayerIdx) + "'s turn"

func _input(event):
	if event.is_action_pressed("ui_accept"): # Space bar
		toggle_view()

# TODO: Toggle does not yet work in discard mode.
# When discard mode, deactivate cards drawing, show how many to discard

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
		print("All actions used. Player " + str(currentPlayerIdx) + "'s turn is over.")
		_discard_if_too_many_cards()
		$CurrentPlayerLabel.text = "Player " + str(currentPlayerIdx) + "'s turn"
	
	$ActionsLeftLabel.text = str(currentPlayer.actionsLeft)

func _next_player():
	currentPlayerIdx = (currentPlayerIdx + 1) % players.size()
	currentPlayer = players[currentPlayerIdx]
	currentPlayer.actionsLeft = 3
	
func _discard_if_too_many_cards():
	var excess = currentPlayer.resourcesOnHand.size() - currentPlayer.resourceCapacity
	if excess > 0:
		$MiddleArea/DiscardOverlay.visible = true
		$MiddleArea/DiscardOverlay.move_to_front()
		currentPlayer.start_discard_mode(excess)
		currentPlayer.discard_finished.connect(_on_discard_finished)
	else:
		_next_player()
		$CurrentPlayerLabel.text = "Player " + str(currentPlayerIdx) + "'s turn"

func _on_discard_finished():
	$MiddleArea/DiscardOverlay.visible = false
	currentPlayer.discard_finished.disconnect(_on_discard_finished)
	_next_player()
	$CurrentPlayerLabel.text = "Player " + str(currentPlayerIdx) + "'s turn"
