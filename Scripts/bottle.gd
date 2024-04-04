extends Node2D

@export var alcool_id = "null"
@onready var text = $mytext

var draggable = false
var is_inside_dropable = false
var is_inside_glass_left = false
var is_inside_glass_right = false
var body_ref
var offset: Vector2
var initialPos: Vector2
var fall: Vector2
var end = 800
var velocity = 60
var glass_nbr = 0

func _ready():
	text.text = alcool_id
	text.size.x = (10 * (alcool_id.length()) + 10)

func _process(_delta):
	if draggable:
		if Input.is_action_just_pressed('click'):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Global.is_dragging = true
		if Input.is_action_pressed('click'):
			text.visible = false
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released('click'):
			Global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable:
				tween.tween_property(self,"position",body_ref.position,0.2).set_ease(Tween.EASE_OUT)
			else:
				fall = global_position
				while fall.y < end:
					fall.y += velocity
					velocity *= 2
					tween.tween_property(self,"position",fall,0.2).set_ease(Tween.EASE_OUT)
				velocity = 60
		if is_inside_glass_left:
			var tween = get_tree().create_tween()
			tween.tween_property(self, "rotation_degrees", 45, 0.2).set_ease(Tween.EASE_OUT)
			if Input.is_action_just_pressed('fill') and Global.alcool_bar < 100:
				Global.alcool_bar += 50
				Global.alcool_bar_type[glass_nbr] = alcool_id
				Global.Drink_Served[glass_nbr] = alcool_id;
				glass_nbr += 1
		elif is_inside_glass_right:
			var tween = get_tree().create_tween()
			tween.tween_property(self, "rotation_degrees", -45, 0.2).set_ease(Tween.EASE_OUT)
			if Input.is_action_just_pressed('fill') and Global.alcool_bar < 100:
				Global.alcool_bar += 50
				Global.alcool_bar_type[glass_nbr] = alcool_id
				Global.Drink_Served[glass_nbr] = alcool_id;
				glass_nbr += 1
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(self, "rotation_degrees", 0, 0.2).set_ease(Tween.EASE_OUT)
			

func _on_area_2d_body_entered(body:StaticBody2D):
	if body.is_in_group('dropable') && body.is_empty:
		body.is_empty = false
		body.actuel_bottle = alcool_id
		is_inside_dropable = true
		body.modulate = Color(Color.GRAY, 1)
		body_ref = body
	if body.is_in_group('glass'):
		Global.near_glass = body.get_parent().name
		if body.is_in_group('left'):
			is_inside_glass_left = true
		elif body.is_in_group('right'):
			is_inside_glass_right = true
		body.modulate = Color(Color.GRAY, 1)
		body_ref = body

func _on_area_2d_body_exited(body):
	if body.is_in_group('dropable'):
		if not body.is_empty and body.actuel_bottle == alcool_id:
			body.is_empty = true
		is_inside_dropable = false
		body.modulate = Color(Color.GRAY, 0.7)
		body_ref = body
	if body.is_in_group('glass'):
		Global.near_glass = "null"
		if body.is_in_group('left'):
			is_inside_glass_left = false
		elif body.is_in_group('right'):
			is_inside_glass_right = false
		body.modulate = Color(Color.GRAY, 0.7)
		body_ref = body

func _on_area_2d_mouse_entered():
	if not Global.is_dragging:
		draggable = true
		scale = Vector2(1.1, 1.1)
		text.visible = true

func _on_area_2d_mouse_exited():
	if not Global.is_dragging:
		draggable = false
		scale = Vector2(1, 1)
		text.visible = false
