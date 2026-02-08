extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@onready var camera = $Camera2D
@onready var textureButton = $TextureButton

func _on_button_pressed() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.set_parallel(true) # Run all animations simultaneously
	tween.tween_property(camera, "global_position", Vector2(500, 300), 0.5)
	tween.tween_property(textureButton, "global_position", Vector2(100, 200), 0.5)
