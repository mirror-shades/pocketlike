extends Node2D

onready var fireButton = $ChooseMon/Fire
onready var earthButton = $ChooseMon/Earth
onready var waterButton = $ChooseMon/Water
onready var airButton = $ChooseMon/Air

onready var strengthButton = $ChooseBuff/Strength
onready var defenceButton = $ChooseBuff/Defence
onready var speedButton = $ChooseBuff/Speed
onready var specialButton = $ChooseBuff/Special
onready var healthButton = $ChooseBuff/Health



# Called when the node enters the scene tree for the first time.
func _ready():
	$ChooseBuff.hide()
	
	fireButton.connect("pressed", self, "_fire_button_pressed")
	earthButton.connect("pressed", self, "_earth_button_pressed")
	waterButton.connect("pressed", self, "_water_button_pressed")
	airButton.connect("pressed", self, "_air_button_pressed")
	
	strengthButton.connect("pressed", self, "_strength_button_pressed")
	defenceButton.connect("pressed", self, "_defence_button_pressed")
	speedButton.connect("pressed", self, "_speed_button_pressed")
	specialButton.connect("pressed", self, "_special_button_pressed")
	healthButton.connect("pressed", self, "_health_button_pressed")


func _fire_button_pressed():
	functions.craftStarterMonster("playerTeam", 1, 5)
	functions.craftStarterMonster("playerTeam", 4, 5)
	functions.craftStarterMonster("playerTeam", 7, 5)
	$ChooseMon.hide()
	$ChooseBuff.show()

func _earth_button_pressed():
	functions.craftStarterMonster("playerTeam", 4, 5)	
	$ChooseMon.hide()
	$ChooseBuff.show()

func _water_button_pressed():
	functions.craftStarterMonster("playerTeam", 7, 10)	
	$ChooseMon.hide()
	$ChooseBuff.show()

func _air_button_pressed():
	functions.craftStarterMonster("playerTeam", 10, 5)	
	$ChooseMon.hide()
	$ChooseBuff.show()

func _strength_button_pressed():
	functions.buff(state.monsters["playerTeam"][0], "strength", 5)
	get_tree().change_scene("res://scenes/Game.tscn")

func _defence_button_pressed():
	functions.buff(state.monsters["playerTeam"][0], "defence", 5)
	get_tree().change_scene("res://scenes/Game.tscn")

func _speed_button_pressed():
	functions.buff(state.monsters["playerTeam"][0], "speed", 5)
	get_tree().change_scene("res://scenes/Game.tscn")

func _special_button_pressed():
	functions.buff(state.monsters["playerTeam"][0], "special", 5)
	get_tree().change_scene("res://scenes/Game.tscn")

func _health_button_pressed():
	functions.buff(state.monsters["playerTeam"][0], "hp", 5)
	get_tree().change_scene("res://scenes/Game.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
