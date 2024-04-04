extends Node2D

func _on_start_button_down():
	get_tree().change_scene_to_file("res://Scenes/main.tscn");

func _on_options_button_down():
	pass # Replace with function body.

func _on_exit_button_down():
	get_tree().quit();
