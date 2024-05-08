extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Back.connect("pressed", self, "_back_button_pressed")

func _back_button_pressed():
	get_tree().change_scene("res://scenes/Game.tscn")
