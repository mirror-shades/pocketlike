extends Node

var gold = 1000;
var parkTickets = 5;
var currentTown = "Roseville"
var currentPark = "Lumpy Springs"
var currentXY = 0
var itemMap = []
var inventory = []
var position = Vector2()
var direction = Vector2()

var parkList = {"Lumpy Springs":[14, 18, 36, 37, 38, 39, 40, 41, 109, 111, 13, 16, 17, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54,],"Crumpled Mountain":[26, 27, 30, 33, 40, 55, 58, 61, 64, 67, 68, 88, 91, 92, 93, 102, 103, 106,122, 123, 124, 125, 127, 129, 131, 133, 136, 139, 142,],"Shaggy Plains":[70, 71, 73, 74, 76, 77, 79, 81, 83, 85, 87, 107, 108, 116, 117, 118, 119,120, 121, 96, 97, 98, 101, 56, 59, 62, 65, 69, 72, 86, 89, 94, 99],"Soggy Mines":[19, 24, 25, 28, 29, 31, 32, 34, 35, 75, 78, 80, 82, 84, 143, 104, 113, 114, 90, 95, 100, 105,],"National Park":[115, 126, 128, 130, 132, 134, 137, 140, 20, 21, 22, 23, 38, 57, 60, 63, 66, 110, 112, 135, 138, 141, 144,],}

var activeTeam = [];
var monsters = {"playerTeam":{},"enemyTeam":{}}

var monPic1 = preload("res://img/monsters/blank.png")
var monPic2 = preload("res://img/monsters/blank.png")
var monPic3 = preload("res://img/monsters/blank.png")


