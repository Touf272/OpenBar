extends Node2D

@onready var main = $"../"

func _on_resume_button_down():
	main.pause_game();

func _on_options_button_down():
	pass # Replace with function body.

func _on_main_menu_button_down():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn");
