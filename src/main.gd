extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


var gameScene = preload("res://src/game/game_scene.tscn")
func _on_ready_button_pressed() -> void:
	var instance = gameScene.instantiate() as GameScene
	for n in [$MainMenu/VBoxContainer/NamePlayer1.text,
			$MainMenu/VBoxContainer/NamePlayer2.text,
			$MainMenu/VBoxContainer/NamePlayer3.text,
			$MainMenu/VBoxContainer/NamePlayer4.text,
			$MainMenu/VBoxContainer/NamePlayer5.text]:
		if n != "":
			instance.add_player(n)
	add_child(instance)
	instance.start()
		
	$MainMenu.hide()
