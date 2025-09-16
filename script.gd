extends Control

@onready var name_input = $LineEdit
@onready var confirm_button = $Button
@onready var feedback = $Feedback

func _ready():
	confirm_button.pressed.connect(_on_confirm_pressed)

func _on_confirm_pressed():
	var entered_name = name_input.text.strip_edges()
	
	if entered_name == "":
		feedback.text = "Name cannot be empty."
		return
	
	Globals.player_name = entered_name
	feedback.text = "Name saved: " + entered_name
	
	get_tree().change_scene_to_file("res://Game.tscn")
