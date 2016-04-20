
extends Node2D

var last_scene

func set_last_scene(node):
	last_scene = node

func _ready():
	set_process(true)
	


func _process(delta):
	if Input.is_action_pressed("escape"):
		get_node("/root/player").change_scene(last_scene)