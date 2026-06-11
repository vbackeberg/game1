class_name CardResource
extends Node3D

@export var resourceValue: int
var slot: int

signal pressed()

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			print("pressed mouse")
			pressed.emit()
						
	if event is InputEventScreenTouch:
		if event.pressed == true:
			print("pressed touch")
			pressed.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func select(forDiscard := false):
	self.modulate = Color(1.2, 0.8, 0.8) if forDiscard else Color(1.2, 1.2, 0.8) # Yellow and Red tint

func deselect():
	self.modulate = Color(1, 1, 1) # Reset to normal color
