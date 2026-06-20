extends Sprite2D

var isDragging := false
var mouseOffset: Vector2
const delay := 10

func _physics_process(delta: float) -> void:
	if isDragging == true:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", get_global_mouse_position()-mouseOffset, delay * delta)
		 
func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		handleMouseButton(event)

func handleMouseButton(event: InputEventMouseButton) -> void:
	if event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("clicked on sprite")
			// TODO: Does not currently evaluate true
			if get_rect().has_point(to_local(event.position)):
				print("clicked on sprite")
				isDragging = true
				mouseOffset = get_global_mouse_position()-global_position
		else:
			isDragging = false
	
