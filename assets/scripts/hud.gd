
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	update_score(get_node("/root/player").get_score())
	set_process(true)


var message_ttl = 0

func update_score(score):
	get_node("score").set_text(str(score))

func display_message(message, time):
	message_ttl = time
	get_node("message").set_text(message)


func _process(delta):
	
	if message_ttl != 0:
		message_ttl -= delta
		if message_ttl <= 0:
			get_node("message").set_text("")
			message_ttl = 0