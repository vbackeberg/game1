extends Node

var middleVisible: bool
var currentPlayer: PlayerArea
var currentPlayerIdx: int
var players: Array[PlayerArea]
var twelvePointsReached: bool
var lastTurn: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	players = [$PlayerArea]
	_set_current_player(0)

	$WinOverlay.visible = false
	twelvePointsReached = false
	lastTurn = false
	
	for player in players:
		player.discard_started.connect(_on_discard_started.bind())
		player.discard_finished.connect(_on_discard_finished.bind())


func _input(event):
	if event.is_action_pressed("ui_accept"): # Space bar
		toggle_view()

func toggle_view():
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.set_parallel(true) # Run all animations simultaneously
	tween.tween_property($Camera2D, "global_position", Vector2(0, 300), 0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_action_used():
	currentPlayer.actionsUsed += 1
	var actionsLeft = currentPlayer.actionsThisTurn - currentPlayer.actionsUsed

	if actionsLeft == 0:
		print("All actions used. Player " + str(currentPlayerIdx) + "'s turn is over.")
		
		# TODO Deselect r virt and dia. Consider Clean Up Phase
		for r in currentPlayer.selectedResources:
			r.deselect()
		
		for d in currentPlayer.selectedDiamonds:
			d.deselect()
		
		currentPlayer.selectedResources.clear()
		currentPlayer.selectedVirtualResources.clear()
		currentPlayer.selectedDiamonds.clear()

		currentPlayer.discard_if_too_many_cards()
	
	$ActionsLeftLabel.text = str(actionsLeft)

func _on_discard_started():
	$MiddleArea.on_discard_started()

func _on_discard_finished():
	$MiddleArea.on_discard_finished()
	_next_player()

func _next_player():
	if currentPlayer.victoryPoints >= 12:
		print("Player " + str(currentPlayerIdx) + " has " + str(currentPlayer.victoryPoints) + " points. Last round!")
		twelvePointsReached = true
		
	if twelvePointsReached && currentPlayerIdx == 0:
		lastTurn = true

	if lastTurn && currentPlayerIdx == 0:
		_find_winner()
		return

	currentPlayer.actionsThisTurn = currentPlayer.actionsPerTurn
	currentPlayer.actionsUsed = 0
	currentPlayer.visible = false
	$MiddleArea.visible = true

	_set_current_player((currentPlayerIdx + 1) % players.size())

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
	$CurrentPlayerLabel.text = "Player " + str(currentPlayerIdx) + "'s turn"
	$ActionsLeftLabel.text = str(currentPlayer.actionsThisTurn - currentPlayer.actionsUsed)

## Used by character that adds 3 actions.
func _on_actions_left_changed():
	$ActionsLeftLabel.text = str(currentPlayer.actionsThisTurn)
