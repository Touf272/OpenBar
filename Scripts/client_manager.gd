extends Node2D

var clientsData = {};
var current = "start";
var next = "1";
var nb_clients_on_screen = 0;
var clients_on_screen = [];
var data_file_path = "res://Json/Clients.json";
var one_client = preload("res://Scenes/client.tscn");
var can_enter = true;
var client_ready = false;

func _ready():
	clientsData = load_json_file(data_file_path);

func _process(_delta):
	handle_clients();

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

func handle_clients():
	if (nb_clients_on_screen == 0 && can_enter):
		create_new_client();
		client_ready = true;
	if (Input.is_action_just_pressed("Next_client") && nb_clients_on_screen != 0):
		can_enter = false;
		walk_out();
		nb_clients_on_screen -= 1;
	if (nb_clients_on_screen < 0):
		nb_clients_on_screen = 0;

func walk_out():
	Global.is_client_installed = false
	var client = get_children();
	var client_to_delete = client[0];
	Global.client_gone = true
	while (client_to_delete.position.x < 600):
		can_enter = false;
		client_to_delete.position.x += 4;
		client_to_delete.position.y += 4;
		await get_tree().create_timer(0.001).timeout
	client_to_delete.call_deferred("free")
	can_enter = true;
	Global.alcool_bar_type = ["null", "null"]

func create_new_client():
	if (current == "start" || next != "NULL"):
		current = next;
		next = clientsData[current]["next"]
		var new_client = one_client.instantiate();
		add_child(new_client);
		nb_clients_on_screen += 1;
		new_client.get_node("PlaceholderBartender").set_texture(load(clientsData[current]["sprite"]))

func set_sprite():
	var client = get_children();
	var added_client = get_node(client[0]);
	added_client.PlaceholderBartender.set_texture(clientsData[current]["sprite"])
	nb_clients_on_screen += 1;
