extends Node2D


var main_scene

func _ready():
	set_process(true)
	
	main_scene = load("scenes/main.scn").instance()

func _process(delta):
	
	if not get_node("title_anim").is_playing() and not get_node("blink_animation").is_playing():
		get_node("blink_animation").play("blink")
	
	if Input.is_action_pressed("jump"):
		get_node("/root/player").change_scene(main_scene)

func _on_settings_button_pressed():
	var settings = load("scenes/settings.scn").instance()
	settings.set_last_scene(self)
	get_node("/root/player").change_scene(settings)