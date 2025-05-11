extends Sprite2D

var cards: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cards = []
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_draw_card():
	if cards.size() == 0:
		_replenish()
		
func _replenish():
	pass

var deck = [
	{ number: 1 },
	{ number: 2 }
]
