extends Node2D

var is_dragging := false
var mouse_offset: Vector2
const delay := 1

#TODO: collision shape determines front back sizes and detects drag input

@onready
var shape: RectangleShape2D = $CollisionShape2D.shape

#func _ready() -> void:
	#var size := $CollisionShape2D.shape

	#front.centered = true
	#back.centered = true
#
	#front.scale = Vector2(
		#size.x / front.texture.get_width(),
		#size.y / front.texture.get_height()
	#)
#
	#back.scale = Vector2(
		#size.x / back.texture.get_width(),
		#size.y / back.texture.get_height()
	#)

func _physics_process(delta: float) -> void:
	if is_dragging:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", get_global_mouse_position() - mouse_offset, delay * delta)
		
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		handle_mouse_button(event)

func handle_mouse_button(event: InputEventMouseButton) -> void:
	if event.button_index != MOUSE_BUTTON_LEFT:
		return

	if event.pressed:
		if $CollisionShape2D.get_rect().has_point(to_local(event.position)):
			is_dragging = true
			mouse_offset = get_global_mouse_position() - global_position
	else:
		is_dragging = false
