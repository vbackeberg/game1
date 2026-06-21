extends Sprite2D

var is_dragging := false
var mouse_offset: Vector2
const delay := 1

func _physics_process(delta: float) -> void:
	if is_dragging:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", get_global_mouse_position() - mouse_offset, delay * delta)
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		handle_mouse_button(event)

func handle_mouse_button(event: InputEventMouseButton) -> void:
	if event.button_index != MOUSE_BUTTON_LEFT:
		return

	if event.pressed:
		if get_rect().has_point(to_local(event.position)):
			is_dragging = true
			mouse_offset = get_global_mouse_position() - global_position
	else:
		is_dragging = false
