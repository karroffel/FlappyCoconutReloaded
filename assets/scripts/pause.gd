extends Node2D


var last_scene
var processed_input


func set_last_scene(node):
	last_scene = node

func _ready():
	processed_input = last_scene.is_processing_input()
	last_scene.set_process_input(false)

func _on_settings_pressed():
	var settings = load("scenes/settings.scn").instance()
	settings.set_last_scene(self)
	get_node("/root/player").change_scene(settings)


func _on_continue_pressed():
	last_scene = null
	var main_scene = load("scenes/main.scn").instance()
	get_node("/root/player").change_scene(main_scene)


func _on_quit_pressed():
	get_node("/root/player").quit_game()
