extends Node2D

func _ready():
	if Globals.character_path != "":
		var character_scene = load(Globals.character_path).instantiate()
		add_child(character_scene)
