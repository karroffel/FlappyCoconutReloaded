
extends KinematicBody2D


var y_pos = 200
var y_acceleration = 0.0

var was_high = true
var got_point = false

var just_jumped = false

var jump_state = false

const GRAVITIY = -9.81

func _ready():
	set_fixed_process(true)
	set_process(true)
	
	
func _fixed_process(delta):
	y_acceleration += delta * GRAVITIY
	
	if Input.is_action_pressed("jump"):
		if not jump_state:
			just_jumped = true
		jump_state = true
		was_high = true
		y_acceleration = 4
	elif jump_state:
		jump_state = false

	
	move(Vector2(0, -y_acceleration))
	
	if is_colliding():
		var collider = get_collider()
		if collider.is_in_group("wall"):
			get_node("/root/player").stop_game()
		elif collider.is_in_group("bird"):
			got_point = true
			get_node("/root/player").score_point()
			collider.play_animation()


func _process(delta):
	
	if y_acceleration <= 0 and not get_node("AnimationPlayer").is_playing() and was_high:
		get_node("AnimationPlayer").play("coconut_fall")
		was_high = false
		
		
	if just_jumped:
		get_node("jump_sound").play("jump")
		just_jumped = false
	
	if got_point:
		get_node("point_sound").play("point")
		got_point = false
	
	if y_acceleration > 0:
		get_node("sprite").set_rot(0)
		
	var pos = get_pos()
	if pos.y < 0 or pos.y > 400:
		get_node("/root/player").stop_game()