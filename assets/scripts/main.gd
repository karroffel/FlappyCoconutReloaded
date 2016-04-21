
extends Node2D

var walls = []
var birds = []



func _ready():
	
	add_to_group("game")

	var speed = get_node("/root/player").get_speed()
	print("speed: " + str(speed))
	
	set_process(true)

	
	for i in range(1, 5):
		var wall = load("scenes/wall.scn").instance()
		wall.set_speed(speed)
		wall.set_pos(Vector2(200 + i * (800 - 3 * 48) / 3, rand_range(-60, 60)))
		walls.append(wall)
		add_child(wall)
	
	for i in range(1, 4):
		var bird = load("scenes/bird.scn").instance()
		bird.set_speed(speed)
		bird.set_pos(Vector2(200 + ((800 - 3 * 48) / 3) / 2 +   i * 2 * ((800 - 3 * 48) / 3) - 14, rand_range(75, 325)))
		birds.append(bird)
		add_child(bird)
	
	var hud = get_node("hud")
	remove_child(hud)
	add_child(hud)



var esc_was_pressed = false

func update_speed(speed):
	
	
	
	for wall in walls:
		wall.set_speed(speed)
	
	for bird in birds:
		bird.set_speed(speed)
	
	get_node("coconut").set_speed(speed)


func _process(delta):
	var esc = Input.is_action_pressed("escape")
	if not esc and esc_was_pressed:
		set_process(false)
		var pause = load("scenes/pause_screen.scn").instance()
		pause.set_last_scene(self)
		get_node("/root/player").change_scene(pause)
	
	if esc:
		esc_was_pressed = true