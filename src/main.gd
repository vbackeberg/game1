extends Node

var playerArea: Node2D
var middleArea: Node2D
var middleVisible: bool

var currentPlayerIdx: int
var currentPlayer: Node2D
var players: Array[Node2D]
var startingPlayer: Node2D
var twelvePointsReached: bool
var lastTurn: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	middleArea = $MiddleArea
	players = [$PlayerArea, $PlayerArea2]
	startingPlayer = players[0]
	_set_current_player(0)

	$WinOverlay.visible = false
	twelvePointsReached = false
	lastTurn = false


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
	if currentPlayer.victoryPoints >= 12:
		print("Player " + str(currentPlayerIdx) + " has " + str(currentPlayer.victoryPoints) + " points. Last round!")
		twelvePointsReached = true
		
	if twelvePointsReached && currentPlayer == startingPlayer:
		lastTurn = true

	if lastTurn && currentPlayer == startingPlayer:
		_find_winner()
		return

	currentPlayer.visible = false
	middleArea.visible = true

	_set_current_player((currentPlayerIdx + 1) % players.size())

func on_resource_spent(value):
	$MiddleArea.graveyardResources.append(value)

func on_diamond_spent(d):
	$MiddleArea.graveyardCharacters.append(d)


## Finds player with highest points and displays them as Winner
func _find_winner():
	var sortedPlayers = players.duplicate()
	sortedPlayers.sort_custom(func(a, b): return a.victoryPoints > b.victoryPoints || (a.victoryPoints == b.victoryPoints && a.diamonds.size() > b.diamonds.size()))
	
	print("Final Rankings:")
	for i in range(sortedPlayers.size()):
		var player = sortedPlayers[i]
		print("Player " + str(i) + ": " + str(player.victoryPoints) + " victory points")
	
	$ActionsLeftLabel.visible = false
	$CurrentPlayerLabel.visible = false
	
	$WinOverlay.visible = true
	$WinOverlay/WinnerLabel.text = "Player " + str(sortedPlayers[0].playerName) + " has won!"

func _on_new_game_button_pressed() -> void:
	get_tree().reload_current_scene()

func _set_current_player(nextPlayer: int):
	currentPlayerIdx = nextPlayer
	currentPlayer = players[currentPlayerIdx]
	currentPlayer.actionsLeft = currentPlayer.actionsPerTurn
	$CurrentPlayerLabel.text = "Player " + str(currentPlayerIdx) + "'s turn"
	$ActionsLeftLabel.text = str(currentPlayer.actionsLeft)
