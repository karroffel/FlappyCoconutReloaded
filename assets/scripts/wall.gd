
extends KinematicBody2D

const SPEED = 70

var pos

func _ready():
	add_to_group("wall")
	set_process(true)
	set_fixed_process(true)


func _fixed_process(delta):
	move(Vector2(-SPEED * delta, 0))



func _process(delta):
	pos = get_pos()

	if pos.x < -24:
		var diff = -pos.x
		pos.x = 4 * (800 - 3 * 48) / 3 - diff
		pos.y = rand_range(-60, 60)

	pos.x -= SPEED * delta
	set_pos(pos)
