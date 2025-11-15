extends HBoxContainer

func _ready() -> void:
	$CardResource1.pressed.connect(_on_pressed.bind(1))
	$CardResource2.pressed.connect(_on_pressed.bind(2))
	$CardResource3.pressed.connect(_on_pressed.bind(3))
	$CardResource4.pressed.connect(_on_pressed.bind(4))
	$CardResource5.pressed.connect(_on_pressed.bind(5))
	$CardResource6.pressed.connect(_on_pressed.bind(6))
	$CardResource7.pressed.connect(_on_pressed.bind(7))
	$CardResource8.pressed.connect(_on_pressed.bind(8))

signal number_selected(number: int)

func _on_pressed(number: int):
	number_selected.emit(number)
