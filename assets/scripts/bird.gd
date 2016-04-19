
extends KinematicBody2D

const SPEED = 70 

var has_played = false

func _ready():
	add_to_group("bird")
	set_fixed_process(true)
	set_process(true)


func _fixed_process(delta):
	move(Vector2(-SPEED * delta, 0))



func _process(delta):
	var pos = get_pos()
	
	pos.x -= SPEED * delta;

	
	if (has_played and not get_node("AnimationPlayer").is_playing()) or pos.x < -20:
		var posx = pos.x
		pos = Vector2(800 + 48 + 17 + 17 / 2 + posx, rand_range(75, 325))
		has_played = false
		
	set_pos(pos)
		


func play_animation():
	get_node("AnimationPlayer").play("bird_fly")
	has_played = true