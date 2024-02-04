extends Node2D


func _ready():
	$Back.connect("pressed", self, "_back_button_pressed")
	$Shop.connect("pressed", self, "_shop_button_pressed")

func _back_button_pressed():
	get_tree().change_scene("res://scenes/Game.tscn")

func _shop_button_pressed():
	get_tree().change_scene("res://scenes/Shop.tscn")
