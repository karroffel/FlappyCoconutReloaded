
extends Node2D


func _ready():
	var menu_scene = load("scenes/menu.scn").instance()
	get_node("active_scene").replace_by(menu_scene)
	get_child(0).set_name("active_scene")


