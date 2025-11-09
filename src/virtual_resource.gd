class_name VirtualResource
extends TextureButton

var resourceValue: int

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
