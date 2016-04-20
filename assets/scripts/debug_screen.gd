
extends VBoxContainer

# member variables here, example:
# var a=2
# var b="textvar"

var fps = 0
var is_active = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	hide()


func _process(delta):
	
	if Input.is_action_pressed("debug_key"):
		toggle_screen()

	fps = 1 / delta
	get_node("fps/fps1").set_text("FPS: ")
	get_node("fps/fps2").set_text(str(fps))
	
func toggle_screen():
	
	if is_active:
		is_active = false
	else: 
		is_active = true
	
	if is_active:
		hide()
	else:
		show()