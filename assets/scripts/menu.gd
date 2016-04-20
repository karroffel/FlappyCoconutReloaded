
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"


func _ready():
	set_process(true)


func _process(delta):
	if Input.is_action_pressed("jump"):
		var main_scene = load("scenes/main.scn").instance()
		get_node("/root/player").change_scene(main_scene)