extends Node2D

signal dropped

var is_dragging := false
var mouse_offset: Vector2
const delay := 1

var is_snapping := false
var snap_position: Vector2
const snap_delay := 10

func _physics_process(delta: float) -> void:
	if is_dragging:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", get_global_mouse_position() - mouse_offset, delay * delta)
	elif is_snapping:
		if position == snap_position:
			is_snapping = false
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", snap_position, snap_delay * delta)
		
		
func _on_input_event(__: Node, event: InputEvent, ___: int) -> void:
	if event is InputEventMouseButton:
		handle_mouse_button(event)

func handle_mouse_button(event: InputEventMouseButton) -> void:
	if event.button_index != MOUSE_BUTTON_LEFT:
		return

	if event.pressed:
		is_dragging = true
		is_snapping = false
		mouse_offset = get_global_mouse_position() - global_position
	else:
		is_dragging = false
		dropped.emit()

func snap_to(target_position: Vector2):
	snap_position = target_position
	is_snapping = true

# Exposes the textures from the inner scene here so they can be set when instancing this scene on characters
@export var front_texture: Texture2D:
	set(tex): $Front.texture = tex
	get: return $Front.texture
@export var back_texture: Texture2D:
	set(tex): $Back.texture = tex
	get: return $Back.texture
