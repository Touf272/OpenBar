extends Node2D

var alcool1;
var alcool2;
var fruit;
var get_fruit;

var alcoolData = {};
var syrupData = {};
var fruitData = {};

func load_json_file(filePath: String):
	if (FileAccess.file_exists(filePath)):
		var dataFile = FileAccess.open(filePath, FileAccess.READ);
		var parsedResult = JSON.parse_string(dataFile.get_as_text());
		
		if parsedResult is Dictionary:
			return parsedResult;
		else:
			print("Error reading file");
	else:
		print("File doesn't exist");

func _ready():
	alcoolData = load_json_file("res://Json/Alcool.json");
	syrupData = load_json_file("res://Json/Syrup.json");
	fruitData = load_json_file("res://Json/Fruit.json");
	create_order();

func create_order():
	randomize();
	#get_fruit = randi_range(0, 1);
	#if (get_fruit == 0):
		#fruit = fruitData[str(randi_range(1, 3))];
		#$Fruit.append_text(fruit["name"]);
	alcool1 = alcoolData[str(randi_range(1, 4))];
	alcool2 = alcoolData[str(randi_range(1, 4))];
	$Alcool1.append_text(alcool1["name"]);
	$Alcool2.append_text(alcool2["name"]);
	Global.Command[0] = alcool1["name"];
	Global.Command[1] = alcool2["name"];
	if (Global.is_client_installed == true):
		DialogueManager.show_dialogue_balloon(load("res://Dialogues/random_discussion.dialogue"))
