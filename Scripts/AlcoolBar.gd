extends TextureProgressBar

@export var is_fillable: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func test():
	print("test")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var node_name = get_parent().name
	if Global.near_glass == node_name and Input.is_action_just_pressed('fill') and value < 100:
		value += 50
	if Global.client_gone:
		value = 0
		Global.client_gone = false
	
