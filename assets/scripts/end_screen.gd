
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var score = 0

func _ready():
	set_process(true)
	get_node("end/score").set_text(str(get_node("/root/player").get_score()))
	get_node("SamplePlayer").play("collision")



func _process(delta):
	if Input.is_action_pressed("jump"):
		get_tree().change_scene("res://scenes/main.scn")
		