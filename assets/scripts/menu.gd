
extends Node2D

var last_scene
var processed

func set_last_scene(node):
	last_scene = node

func _ready():
	set_process(true)
	processed = last_scene.is_processing()
	last_scene.set_process(false)
	


func _process(delta):
	if Input.is_action_pressed("escape"):
		last_scene.set_process(processed)
		get_node("/root/player").change_scene(last_scene)