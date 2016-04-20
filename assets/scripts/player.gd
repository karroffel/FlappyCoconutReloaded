
extends Node

var score
var all_score
var deaths

var jump_sound_volume = 1.0
var point_sound_volume = 1.0
var collision_sound_volume = 1.0



var is_in_menu = false


var messages = {
	1: "A good start!",
	5: "Go on, bro!",
	10: "Are you playing legit?",
	15: "You are getting better!",
	20: "Ei huono!",
	25: "Dude, you're on a run!",
	30: "O.o",
	35: "¡35 muertes!",
	40: "¿Soy loco?",
	42: "Are you expecting an easter egg?",
	45: "Gotta catch them all!",
	50: "I'm getting tired.. Loose already!",
	55: "55, just infinite more to go!",
	60: "Ok, not inifinite.. I'm not using BigNums",
	65: "With a uint64_t in you still have 4294967230 to go",
	70: "Man, come on...",
	75: "Maybe that's the wrong attitude!",
	80: "Go on, you can do it!",
	85: "Don't be disappointed if you loose",
	90: "Even if that would be a shame...",
	95: "Just don't let the pressure get to high",
	100: "100? You can do 100000!!",
	105: "Are you a wizard?",
	
	1337: "gr8 m8",
	
	9001: "IT'S OVER 9000!!!!!"
}


func get_is_in_menu():
	return is_in_menu

func set_is_in_menu(m):
	is_in_menu = m


func _ready():
	score = 0
	all_score = 0
	deaths = 0

func get_score():
	return score
	
func get_all_score():
	return all_score

func set_score(s):
	score = s

func score_point():
	score += 1
	all_score += 1
	get_node("/root/player").get_hud().update_score(score)
	if messages.has(score):
		get_node("/root/player").get_hud().display_message(messages[score], 2)




func get_hud():
	return active_scene().get_node("hud")



func get_point_sound_volume():
	return point_sound_volume

func get_jump_sound_volume():
	return jump_sound_volume

func get_collision_sound_volume():
	return collision_sound_volume


func set_point_sound_volume(v):
	point_sound_volume = v

func set_jump_sound_volume(v):
	jump_sound_volume = v

func set_collision_sound_volume(v):
	collision_sound_volume = v



func change_scene(node):
	var as = active_scene()
	get_tree().get_current_scene().remove_child(as)
	get_tree().get_current_scene().add_child(node)
	get_tree().get_current_scene().move_child(node, 0)
	get_tree().get_current_scene().get_child(0).set_name("active_scene")
	

func active_scene():
	return get_tree().get_current_scene().get_node("active_scene")


func death():
	deaths += 1
	#var end_screen = load("scenes/end_screen.scn").instance()
	#change_scene(end_screen)
	var child_count = active_scene().get_child_count()
	var child
	for i in range (0, child_count):
		child = active_scene().get_child(i)
		child.set_process(false)
		if child.get_name() == "coconut":
			child.set_dying(true)
			child.set_y_acceleration(0)
	active_scene().set_process(false)
	
	var end_screen = load("scenes/end_screen.scn").instance()
	end_screen.set_name("end_screen")
	get_tree().get_current_scene().add_child(end_screen)

func get_deaths():
	return deaths