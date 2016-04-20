
extends StaticBody2D

const SPEED = 140

var pos

func _ready():
	add_to_group("wall")
	set_process(true)



func _process(delta):
	pos = get_pos()

	if pos.x < -24:
		var diff = pos.x
		# pos.x = 4 * (800 - 3 * 48) / 3 + diff
		# Hope this is better :(
		pos.x = 800 + 48 + 24 + diff
		pos.y = rand_range(-60, 60)

	pos.x -= SPEED * delta
	set_pos(pos)
