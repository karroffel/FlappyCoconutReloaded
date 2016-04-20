
extends Node2D

var walls = []


func _ready():
	
	add_to_group("game")

	
	for i in range(1, 5):
		var wall = load("scenes/wall.scn").instance()
		wall.set_pos(Vector2(200 + i * (800 - 3 * 48) / 3, rand_range(-60, 60)))
		walls.append(wall)
		add_child(wall)
	
	for i in range(1, 3):
		var bird = load("scenes/bird.scn").instance()
		bird.set_pos(Vector2(200 + ((800 - 3 * 48) / 3) / 2 +   i * 2 * ((800 - 3 * 48) / 3) - 14, rand_range(75, 325)))
		add_child(bird)
	
	var hud = get_node("hud")
	remove_child(hud)
	add_child(hud)