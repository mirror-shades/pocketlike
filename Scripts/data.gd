extends Node

#var monsterList = JSON.load("res://data/monsterList.json")
#var moveList = JSON.load("res://data/moveList.json")

var monList;
var moveList;
var itemList

func _ready():
	var file = File.new()
	file.open("res://data/monsterList.json", file.READ)
	var text = file.get_as_text()
	monList = JSON.parse(text)
	file.close()
	
	var file2 = File.new()
	file2.open("res://data/moveList.json", file2.READ)
	var text2 = file2.get_as_text()
	moveList = JSON.parse(text2)
	file2.close()
	
	var file3 = File.new()
	file3.open("res://data/itemList.json", file3.READ)
	var text3 = file3.get_as_text()
	itemList = JSON.parse(text3)
	file3.close()
