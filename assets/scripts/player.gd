
extends Node

var score

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
	
	9001: "IT'S OVER 9000!!!!!"
}

func _ready():
	score = 0

func get_score():
	return score

func set_score(s):
	score = s

func score_point():
	score += 1
	get_tree().get_current_scene().get_node("hud").update_score(score)
	if messages.has(score):
		get_tree().get_current_scene().get_node("hud").display_message(messages[score], 2)


func stop_game():
	get_tree().change_scene("res://scenes/end_screen.scn")