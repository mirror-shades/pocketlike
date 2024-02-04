extends Node

export var _level = ["CrumpledMountain", "Town"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_player():
	return get_node("/root/"+_level[0]+"/Scene/"+_level[1]+"/YSort/Player")
	

func get_scene_manager():
	return get_node("/root/SceneManager")
