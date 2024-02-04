extends Node2D

onready var panel = $Panel

func _ready():
	var b1 = Button.new()
	b1.margin_left = 5
	b1.margin_top = 5
	b1.text = "Lumpy Springs" 

	var b2 = Button.new()
	b2.margin_left = 5
	b2.margin_top = 30
	b2.text = "Crumpled Mountain" 

	var b3 = Button.new()
	b3.margin_left = 5
	b3.margin_top = 55
	b3.text = "Daffow Hills" 

	var b4 = Button.new()
	b4.margin_left = 5
	b4.margin_top = 80
	b4.text = "Soggy Mines" 

	var b5 = Button.new()
	b5.margin_left = 5
	b5.margin_top = 105
	b5.text = "National Park" 
	
	b1.connect("pressed", self, "level1")
	b2.connect("pressed", self, "level2")
	b3.connect("pressed", self, "level3")
	b4.connect("pressed", self, "level4")
	b5.connect("pressed", self, "level5")
	
	panel.add_child(b1)
	panel.add_child(b2)
	panel.add_child(b3)
	panel.add_child(b4)
	panel.add_child(b5)


func level1():
	get_tree().change_scene("res://Levels/LumpySprings.tscn")
	Utils._level = "LumpySprings"

func level2():
	get_tree().change_scene("res://Levels/CrumpledMountain.tscn")
	Utils._level = "CrumpledMountain"

func level3():
	get_tree().change_scene("res://Levels/LumpySprings.tscn")
	Utils._level = "LumpySprings"

func level4():
	get_tree().change_scene("res://Levels/SoggyMines.tscn")
	Utils._level = "SoggyMines"

func level5():
	get_tree().change_scene("res://Levels/NationalPark.tscn")
	Utils._level = "NationalPark"
