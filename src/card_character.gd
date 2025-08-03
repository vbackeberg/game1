class_name CardCharacter
extends TextureButton

var slot: int

## Returns the cards paid to buy this card or null if it could not be played.
var buy := func(_player): pass
var points: int
var diamonds: int
var effect := func(_player): pass
var asset_path: String
var backside := false

func _init(p_buy, p_points, p_diamonds, p_asset_path) -> void:
	buy = p_buy
	points = p_points
	diamonds = p_diamonds
	asset_path = "res://assets/characters/" + p_asset_path + ".png"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var p = "res://assets/character_back.png" if backside else asset_path
	texture_normal = load(p)
	scale = Vector2(128.0, 200.0) / texture_normal.get_size()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

static func concat(arr: Array) -> String:
	var result = ""
	for num in arr:
		result += str(num)
	return result
