extends Control

func _ready():
	# Espera 2 segundos y luego cambia al menú
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://MainMenu.tscn")
