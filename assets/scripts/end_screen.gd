
extends Node2D


var score = 0

var is_input_pressed = false

func _ready():
	
	is_input_pressed = Input.is_action_pressed("jump")
	
	var scores = get_node("/root/scoreboard").get_scoreboard()
	
	var sorted_names = sort(scores)
	
	var j = 1
	for i in sorted_names:
		var path = "end/top_five/score_" + str(j)
		get_node(path + "/name").set_text(i)
		get_node(path + "/score").set_text(str(scores[i]))
		j += 1
	
	set_process(true)
	var highscore = get_node("/root/player").get_highscore()
	var score = get_node("/root/player").get_score()
	var all_score = get_node("/root/player").get_all_score()
	var death = get_node("/root/player").get_deaths()
	get_node("end/highscore/score").set_text(str(highscore))
	get_node("end/score/score").set_text(str(score))
	get_node("end/death/deaths").set_text(str(death))
	get_node("end/s_d/s_d").set_text(str(float(all_score) / float(death)))
	get_node("/root/player").set_score(0)

func _process(delta):
	if Input.is_action_pressed("jump"):
		is_input_pressed = true
	elif is_input_pressed:
		is_input_pressed = false
		var as = get_tree().get_current_scene().get_node("active_scene")
		get_tree().get_current_scene().remove_child(as)
		var node = get_tree().get_current_scene().get_node("end_screen");
		get_tree().get_current_scene().move_child(node, 0)
		get_tree().get_current_scene().get_child(0).set_name("active_scene")
		
		var main_scene = load("scenes/main.scn").instance()
		get_node("/root/player").change_scene(main_scene)




var global_dict

func sort(dict):
	global_dict = dict
	var keys = dict.keys()
	keys.sort_custom(self, "sort_fun")
	return keys
	
	
func sort_fun(a, b):
	return global_dict[a] > global_dict[b]