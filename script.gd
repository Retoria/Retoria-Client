extends Control

@onready var name_input = $NameInput
@onready var ip_input = $IPInput
@onready var port_input = $PortInput
@onready var host_button = $HostButton
@onready var join_button = $JoinButton
@onready var feedback = $Feedback

const MAX_CLIENTS = 10

func _ready():
	host_button.pressed.connect(_on_host_pressed)
	join_button.pressed.connect(_on_join_pressed)

func _on_host_pressed():
	var entered_name = name_input.text.strip_edges()
	if entered_name == "":
		feedback.text = "Name cannot be empty."
		return

	var port_text = port_input.text.strip_edges()
	if not port_text.is_valid_int():
		feedback.text = "Port must be a number."
		return
	var port = int(port_text)
	if port < 1024 or port > 65535:
		feedback.text = "Port must be between 1024 and 65535."
		return

	Globals.player_name = entered_name
	Globals.server_name = entered_name
	Globals.is_host = true

	var peer = ENetMultiplayerPeer.new()
	var result = peer.create_server(port, MAX_CLIENTS)
	if result != OK:
		feedback.text = "Error while creating server"
		return

	get_tree().get_multiplayer().multiplayer_peer = peer
	feedback.text = "Server created on port %s with name: %s" % [port, entered_name]

	get_tree().change_scene_to_file("res://Game.tscn")

func _on_join_pressed():
	var entered_name = name_input.text.strip_edges()
	if entered_name == "":
		feedback.text = "Name cannot be empty."
		return

	var ip = ip_input.text.strip_edges()
	if ip == "":
		feedback.text = "IP cannot be empty."
		return

	var port_text = port_input.text.strip_edges()
	if not port_text.is_valid_int():
		feedback.text = "Port must be a number."
		return
	var port = int(port_text)
	if port < 1024 or port > 65535:
		feedback.text = "Port must be between 1024 and 65535."
		return

	Globals.player_name = entered_name
	Globals.is_host = false

	var peer = ENetMultiplayerPeer.new()
	var result = peer.create_client(ip, port)
	if result != OK:
		feedback.text = "Cant connect to server"
		return

	get_tree().get_multiplayer().multiplayer_peer = peer
	feedback.text = "Connected to %s:%s as %s" % [ip, port, entered_name]

	get_tree().change_scene_to_file("res://Game.tscn")
