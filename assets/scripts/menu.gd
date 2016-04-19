
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"


func _ready():
	set_process(true)


func _process(delta):
	if Input.is_action_pressed("jump"):
		get_tree().change_scene("res://scenes/main.scn")