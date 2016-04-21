
extends Node

var name


var score
var all_score
var highscore
var deaths

var master_sound_volume
var jump_sound_volume
var point_sound_volume
var collision_sound_volume



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



func _ready():
	get_tree().set_auto_accept_quit(false)
	score = 0
	load_state()
	
	

func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		quit_game()




func get_username():
	return name

func set_username(n):
	name = n



func get_highscore():
	return highscore

func set_hightscore(h):
	highscore = h

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



func get_master_sound_volume():
	return master_sound_volume


func get_point_sound_volume():
	return point_sound_volume

func get_jump_sound_volume():
	return jump_sound_volume

func get_collision_sound_volume():
	return collision_sound_volume


func set_master_sound_volume(v):
	master_sound_volume = v

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
	if score > highscore:
		# send highscore to server?!
		highscore = score
		get_node("/root/scoreboard").send_highscore(name, highscore)
		
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




func quit_game():
	save_state()
	get_tree().quit()
	


const STATS_PATH = "stats.save"
const PASSWORD   = "windowsisttoll"


func load_state():
	var file = File.new()
	if not file.file_exists(STATS_PATH):
		create_initial_save_game(STATS_PATH)
	file.open_encrypted_with_pass(STATS_PATH, File.READ, PASSWORD)
	var text = file.get_as_text()
	file.close()
	
	var dict = {}
	dict.parse_json(text)

	name      = dict["name"]
	all_score = dict["all_score"]
	highscore = dict["highscore"]
	deaths    = dict["deaths"]
	
	master_sound_volume    = dict["master_sound_volume"]
	jump_sound_volume      = dict["jump_sound_volume"]
	point_sound_volume     = dict["point_sound_volume"]
	collision_sound_volume = dict["collision_sound_volume"]




func save_state():
	var file = File.new()
	file.open_encrypted_with_pass(STATS_PATH, File.WRITE, PASSWORD)
	
	var dict = {}
	
	dict["name"]      = name
	dict["all_score"] = all_score
	dict["highscore"] = highscore
	dict["deaths"]    = deaths
	
	dict["master_sound_volume"]    = master_sound_volume
	dict["jump_sound_volume"]      = jump_sound_volume
	dict["point_sound_volume"]     = point_sound_volume
	dict["collision_sound_volume"] = collision_sound_volume
	
	var text = dict.to_json()
	
	file.store_string(text)
	file.close()
	



func create_initial_save_game(path):
	var file = File.new()
	file.open_encrypted_with_pass(path, File.WRITE, PASSWORD)
	var dict = {
		"name": "unnamed",
	
		"all_score": 0,
		"highscore": 0,
		"deaths": 0,
		
		"master_sound_volume": 1.0,
		"jump_sound_volume": 1.0,
		"point_sound_volume": 1.0,
		"collision_sound_volume": 1.0
	}
	var json = dict.to_json()
	file.store_string(json)
	file.close()