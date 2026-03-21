extends Node3D

class_name CardCharacter

@export var data: CardData:
	set(value):
		var card_front = $Front
		var card_back = $Back
		
		data = value




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
