extends Node2D

var old_name

func _ready():
	get_node("name_input").set_text(get_node("/root/player").get_username())
	old_name = get_node("/root/player").get_username()
	get_node("practice_mode_box").set_pressed(get_node("/root/player").get_practice_mode())


func _on_name_input_text_changed( text ):
	if text.is_valid_identifier() and text.length() < 20 or text == "":
		get_node("/root/player").set_username(text)
		get_node("name_input").set_text(text)
		old_name = text
	else:
		get_node("name_input").set_text(old_name)
		
	if text == "":
		get_node("warning").show()
	else:
		get_node("warning").hide()
		
	get_node("name_input").set_cursor_pos(old_name.length())


func _on_practice_mode_box_toggled( pressed ):
	get_node("/root/player").set_practice_mode(pressed)
