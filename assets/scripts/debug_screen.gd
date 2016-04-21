
extends VBoxContainer


var fps = 0
var is_active = false
var was_pressed = false

const FPS_COOLDOWN = 0.5

var fps_ttl = 0

func _ready():
	get_node("header").set_text(get_node("/root/player").get_version())
	set_process(true)
	hide()


func _process(delta):
	
	var player = get_node("/root/player")
	
	var is_pressed = Input.is_action_pressed("debug_key")
	
	if is_pressed and not was_pressed:
		was_pressed = true
		toggle_screen()
	elif was_pressed and not is_pressed:
		was_pressed = false
		
	if is_active:
		
		fps_ttl -= delta
		if fps_ttl <= 0:
			fps_ttl = FPS_COOLDOWN
			fps = 1 / delta
			get_node("fps/fps2").set_text(str(int(fps)))
			
			var speed = player.get_speed()
			get_node("speed/display").set_text(str(int(speed)))
			
	
func toggle_screen():
	
	if is_active:
		hide()
	else:
		show()
		
	is_active = not is_active