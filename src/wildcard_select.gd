extends CanvasLayer

func _ready() -> void:
	$HBoxContainer/CardResource1.pressed.connect(_on_pressed.bind(1))
	$HBoxContainer/CardResource2.pressed.connect(_on_pressed.bind(2))
	$HBoxContainer/CardResource3.pressed.connect(_on_pressed.bind(3))
	$HBoxContainer/CardResource4.pressed.connect(_on_pressed.bind(4))
	$HBoxContainer/CardResource5.pressed.connect(_on_pressed.bind(5))
	$HBoxContainer/CardResource6.pressed.connect(_on_pressed.bind(6))
	$HBoxContainer/CardResource7.pressed.connect(_on_pressed.bind(7))
	$HBoxContainer/CardResource8.pressed.connect(_on_pressed.bind(8))

signal number_selected(number: int)

func _on_pressed(number: int):
	number_selected.emit(number)
