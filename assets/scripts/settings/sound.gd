extends Node2D

func _ready():
	var master_vol = get_node("/root/player").get_master_sound_volume()
	var jump_vol = get_node("/root/player").get_jump_sound_volume()
	var point_vol = get_node("/root/player").get_point_sound_volume()
	var collision_vol = get_node("/root/player").get_collision_sound_volume()
	
	get_node("master/volume").set_value(master_vol * 100)
	get_node("jump/volume").set_value(jump_vol * 100)
	get_node("point/volume").set_value(point_vol * 100)
	get_node("collision/volume").set_value(collision_vol * 100)

func _on_jump_volume_value_changed(value):
	get_node("/root/player").set_jump_sound_volume(value / 100.0)


func _on_point_volume_value_changed(value):
	get_node("/root/player").set_point_sound_volume(value / 100.0)


func _on_collision_volume_value_changed(value):
	get_node("/root/player").set_collision_sound_volume(value / 100.0)


func _on_master_volume_value_changed( value ):
	get_node("/root/player").set_master_sound_volume(value / 100.0)
