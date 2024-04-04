extends StaticBody2D

@onready var fillable = $Glass

var is_empty = true
var actuel_bottle = "null"

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(Color.GRAY, 0.7)

func fill_glass():
	fillable.test()
	
func unfill_glass():
	fillable.test()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.is_dragging and is_empty:
		visible = true
	else:
		visible = false

