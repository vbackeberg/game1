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
	if middleArea.visible == true:
		$MiddleArea.visible = false
		currentPlayer.visible = true
	else:
		$MiddleArea.visible = true
		currentPlayer.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_action_used():
	currentPlayer.actionsLeft -= 1

	if currentPlayer.actionsLeft == 0:
		print("All actions used. Player " + str(currentPlayerIdx) + "'s turn is over.")
		currentPlayer.discard_if_too_many_cards()
	
	$ActionsLeftLabel.text = str(currentPlayer.actionsLeft)

func on_discard_started():
	$MiddleArea.on_discard_started()

func on_discard_finished():
	$MiddleArea.on_discard_finished()
	_next_player()

func _next_player():
	currentPlayer.visible = false
	middleArea.visible = true

	currentPlayerIdx = (currentPlayerIdx + 1) % players.size()
	currentPlayer = players[currentPlayerIdx]
	currentPlayer.actionsLeft = 3
	$CurrentPlayerLabel.text = "Player " + str(currentPlayerIdx) + "'s turn"

func on_resource_spent(value):
		$MiddleArea.graveyardResources.append(value)
