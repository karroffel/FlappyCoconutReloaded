
extends Node2D


var score = 0

func _ready():
	set_process(true)
	get_node("end/score").set_text(str(get_node("/root/player").get_score()))
	get_node("SamplePlayer").play("collision")



func _process(delta):
	if Input.is_action_pressed("jump"):
		var main_scene = load("scenes/main.scn").instance()
		get_node("/root/player").change_scene(main_scene)
		