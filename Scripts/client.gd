extends Node2D

@onready var main = $"../"
var one_order = preload("res://Scenes/order.tscn");

func _ready():
	walk_in();
	create_order();
	#create_dialogue();

func walk_in():
	position = Vector2(-350, 250);
	while (position.x < 100):
		position.x += 4;
		position.y -= 1;
		await get_tree().create_timer(0.001).timeout
	Global.client_come = true

func create_order():
	var my_order = one_order.instantiate();
	my_order.position = Vector2(300, 100);
	add_child.call_deferred(my_order);
	Global.is_client_installed = true

func create_dialogue():
	if (Global.is_client_installed == true):
		DialogueManager.show_dialogue_balloon(load("res://Dialogues/random_discussion.dialogue"))
