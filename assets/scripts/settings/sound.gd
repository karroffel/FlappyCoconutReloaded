extends Node2D

func _ready():
	pass

func _on_jump_volume_value_changed(value):
	get_node("/root/player").set_jump_sound_volume(value / 100.0)


func _on_point_volume_value_changed(value):
	get_node("/root/player").set_point_sound_volume(value / 100.0)


func _on_collision_volume_value_changed(value):
	get_node("/root/player").set_collision_sound_volume(value / 100.0)
