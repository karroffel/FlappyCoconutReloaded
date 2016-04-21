
extends Node2D


func _ready():
	
	set_process(true)
	
	var start_scene = load("scenes/start_screen.scn").instance()
	get_node("active_scene").replace_by(start_scene)
	get_child(0).set_name("active_scene")