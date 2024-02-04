extends Node2D

onready var mon1 = $Mon1
onready var mon2 = $Mon2
onready var mon3 = $Mon3

# Called when the node enters the scene tree for the first time.
func _ready():
	$MonPlate1.hide()
	$MonPlate2.hide()
	$MonPlate3.hide()
	
	var monCenButton = $MonCenButton
	monCenButton.connect("pressed", self, "healAll")

	var inventoryButton = $InventoryButton
	inventoryButton.connect("pressed", self, "_inventory_button_pressed")

	var shopButton = $ShopButton
	shopButton.connect("pressed", self, "_shop_button_pressed")

	var exploreButton = $ExploreButton
	exploreButton.connect("pressed", self, "_explore_button_pressed")
	
	var parkButton = $ParkButton
	parkButton.text = state.currentPark
	parkButton.connect("pressed", self, "_park_button_pressed")
	
	var leaderButton = $LeaderButton
	leaderButton.connect("pressed", self, "_leader_button_pressed")
	
	var label = $Label
	label.text = state.currentTown+" | Gold: "+str(state.gold)+" | Park Tickets: "+str(state.parkTickets)
	setInfo();
	
func healAll():
	for monster in state.monsters["playerTeam"]:
		state.monsters["playerTeam"][monster].currentHealth = state.monsters["playerTeam"][monster].maxHealth
	setInfo()

func _explore_button_pressed():
	get_tree().change_scene("res://Levels/SceneManager.tscn")

func _park_button_pressed():
	if (state.currentPark == "Lumpy Springs"):
		get_tree().change_scene("res://Levels/LumpySprings.tscn")
		Utils._level = ["LumpySprings", "Town"]
	if (state.currentPark == "Crumpled Mountain"):
		get_tree().change_scene("res://Levels/CrumpledMountain.tscn")
		Utils._level = ["CrumpledMountain", "Town2"]
	if (state.currentPark == "Shaggy Plains"):
		get_tree().change_scene("res://Levels/LumpySprings.tscn")
		Utils._level = ["LumpySprings", "Town3"]
	if (state.currentPark == "Soggy Mine"):
		get_tree().change_scene("res://Levels/SoggyMines.tscn")
		Utils._level = ["SoggyMines", "Town4"]
	if (state.currentPark == "National Park"):
		get_tree().change_scene("res://Levels/NationalPark.tscn")
		Utils._level = ["NationalPark", "Town5"]

func _inventory_button_pressed():
	get_tree().change_scene("res://scenes/Inventory.tscn")
	
func _shop_button_pressed():
	get_tree().change_scene("res://scenes/Shop.tscn")
	
func _leader_button_pressed():
	functions.advanceStage()
	
func parse_stats(mon):
	return(String(mon.level)+"\n"+String(mon.attack)+"\n"+String(mon.defence)+"\n"+String(mon.speed)+"\n"+String(mon.special)+"\n"+String(mon.currentXp)+"~"+String(mon.nextLevel))
	
func setInfo():
	var path;
	var mon;
	var length = state.monsters["playerTeam"].size();
	if(length > 0):
		path = "res://img/monsters/"+String(state.monsters["playerTeam"][state.activeTeam[0]].id)+".png"
		mon1.texture = load(path)
		mon2.texture = preload("res://img/monsters/blank.png")
		mon3.texture = preload("res://img/monsters/blank.png")
		$MonPlate1.show()
		mon = state.monsters["playerTeam"][state.activeTeam[0]]
		$MonPlate1/ProgressBar/Label.text = "%d/%d" % [mon.currentHealth, mon.maxHealth]
		$MonPlate1/ProgressBar.max_value = mon.maxHealth
		$MonPlate1/ProgressBar.value = mon.currentHealth
		$MonStats1.text = parse_stats(mon)
		$MonNameType1.text =(mon.name+"\n"+String(mon.type))

	if(length > 1):
		path = "res://img/monsters/"+String(state.monsters["playerTeam"][state.activeTeam[1]].id)+".png"
		mon2.texture = load(path)
		mon3.texture = preload("res://img/monsters/blank.png")
		$MonPlate2.show()
		mon = state.monsters["playerTeam"][state.activeTeam[1]]
		$MonPlate2/ProgressBar/Label.text = "%d/%d" % [mon.currentHealth, mon.maxHealth]
		$MonPlate2/ProgressBar.max_value = mon.maxHealth
		$MonPlate2/ProgressBar.value = mon.currentHealth
		$MonNameType2.text =(mon.name+"\n"+String(mon.type))		
		$MonStats2.text = parse_stats(mon)

		
	if(length > 2):
		path = "res://img/monsters/"+String(state.monsters["playerTeam"][state.activeTeam[2]].id)+".png"
		mon3.texture = load(path)
		$MonPlate3.show()
		mon = state.monsters["playerTeam"][state.activeTeam[2]]
		$MonPlate3/ProgressBar/Label.text = "%d/%d" % [mon.currentHealth, mon.maxHealth]
		$MonPlate3/ProgressBar.max_value = mon.maxHealth
		$MonPlate3/ProgressBar.value = mon.currentHealth
		$MonNameType3.text =(mon.name+"\n"+String(mon.type))
		$MonStats3.text = parse_stats(mon)
