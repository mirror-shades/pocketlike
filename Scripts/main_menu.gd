extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

func _ready():
	
	var PlayButton = $PlayButton
	PlayButton.text = "Play"
	PlayButton.connect("pressed", self, "_play_button_pressed")
	
	var UpgradeButton = $UpgradeButton
	UpgradeButton.text = "Upgrade"
	UpgradeButton.connect("pressed", self, "_upgrade_button_pressed")
	

func _play_button_pressed():
	get_tree().change_scene("res://scenes/Intro.tscn")

func _upgrade_button_pressed():
	pass

# get_tree().change_scene("res://path/to/scene.tscn")PlayButton
