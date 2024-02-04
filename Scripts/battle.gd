extends Node2D

signal textbox_closed

onready var AttackButton = $BattleMenu/Attack
onready var MonstersButton = $BattleMenu/Monsters
onready var ItemsButton = $BattleMenu/Items
onready var FleeButton = $BattleMenu/Flee
onready var BackButton =  $Attacks/Back
onready var b1 =  $Attacks/Attack1
onready var b2 =  $Attacks/Attack2
onready var b3 =  $Attacks/Attack3
onready var b4 =  $Attacks/Attack4

var textbox_closable = false
var result;
var _landing;
var moveList = data.moveList.result
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$Attacks.hide()
	$Items.hide()
	$Monsters.hide()

	setInfo();
	initiateWildBattle();
	
	$Items/Items.get_popup().connect("id_pressed", self, "_use_item_in_battle")
	AttackButton.connect("pressed", self, "_attack_button_pressed")
	MonstersButton.connect("pressed", self, "_monsters_button_pressed")
	BackButton.connect("pressed", self, "_back_button_pressed")
	$Items/Back.connect("pressed", self, "_back_button_pressed")
	$Monsters/Back.connect("pressed", self, "_back_button_pressed")
	FleeButton.connect("pressed", self, "_flee_button_pressed")
	ItemsButton.connect("pressed", self, "_items_button_pressed")

	b1.connect("pressed", self, "_b1_pressed")
	b2.connect("pressed", self, "_b2_pressed")
	b3.connect("pressed", self, "_b3_pressed")
	b4.connect("pressed", self, "_b4_pressed")


	$Monsters/Select1.connect("pressed", self, "_select_1_pressed")
	$Monsters/Mon2/Select2.connect("pressed", self, "_select_2_pressed")

func initiateWildBattle():
	displayText("A wild %s appears!" % state.monsters["enemyTeam"][0].name, "BattleMenu") 
	yield(get_tree().create_timer(1), "timeout")

func initiateTrainerBattle():
	#show trainer? change text to reflect trainer
	displayText("A wild %s appears!" % state.monsters["enemyTeam"][0].name, "BattleMenu") 
	yield(get_tree().create_timer(1), "timeout")

func _select_1_pressed():
	functions.switch_mon(1)
	setInfo()
	_back_button_pressed()
	displayText("Go, %s!" % state.monsters["playerTeam"][state.activeTeam[0]].name, "Fight")
	yield(get_tree().create_timer(1), "timeout")
	if(state.monsters["playerTeam"][state.activeTeam[1]].currentHealth > 0):
		_enemy_move()
		yield(get_tree().create_timer(1), "timeout")

func _select_2_pressed():
	functions.switch_mon(2)
	setInfo()
	_back_button_pressed()
	displayText("Go, %s!" % state.monsters["playerTeam"][state.activeTeam[0]].name, "Fight")
	yield(get_tree().create_timer(1), "timeout")
	if(state.monsters["playerTeam"][state.activeTeam[1]].currentHealth > 0):
		_enemy_move()
		yield(get_tree().create_timer(1), "timeout")

func _process(delta):
	if(result == "Win"):
		displayText("You Win!", "Flee")
	if(result == "Lose"):
		displayText("You Lose!", "Flee")

func _is_team_alive():
	var res = false
	for mon in state.activeTeam:
		if(state.monsters["playerTeam"][mon].currentHealth > 0):
			res = true;
	return(res)

func _is_enemy_team_alive():
	var res = false
	for mon in state.monsters["enemyTeam"]:
		print(mon)
		#if(state.monsters["enemyTeam"][mon].currentHealth > 0):
		#	res = true;
	return(res)

func _items_button_pressed():
	$BattleMenu.hide()
	$Items.show()
	print(_is_team_alive())

func _b1_pressed():
	if(check_speed()):
		process_ally_move_first(0)
	else:
		process_enemy_move_first(0);

func _b2_pressed():
	if(check_speed()):
		process_ally_move_first(1)
	else:
		process_enemy_move_first(1);

func _b3_pressed():
	if(check_speed()):
		process_ally_move_first(2)
	else:
		process_enemy_move_first(2);

func _b4_pressed():
	if(check_speed()):
		process_ally_move_first(3)
	else:
		process_enemy_move_first(3);

func _use_item_in_battle(id):
	var res = use_item(id)
	$Items.build_menu()

func _enemyMonsterAI():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var move = rng.randi_range(0, state.monsters["enemyTeam"][0].moveList.size() - 1)
	return move;

func _enemy_move():
	var _move = 0 #_enemyMonsterAI()
	var move = enemy_move(_move)
	var enemy_attack = String(33)
	var txt = "enemy "+state.monsters["enemyTeam"][0].name+" uses "+moveList[String(state.monsters["enemyTeam"][0].moveList[0])].name
	if(move is Array):
		if(move[1]):
			txt = txt + "\n" + state.monsters["playerTeam"][state.activeTeam[0]].name+" dodges!"
		elif(move[0]):
			txt = txt + "\n" + "Critical hit!!"
	#this display needs to know which move the AI picked
	displayText(txt, "Fight")		

func _ally_move(moveId):
	var move = ally_move(moveId)
	var txt = "ally "+state.monsters["playerTeam"][state.activeTeam[0]].name+" uses "+moveList[String(state.monsters["playerTeam"][state.activeTeam[0]].moveList[0])].name
	if(move is Array):
		print(move)
		if(move[1]):
			txt = txt + "\n" + state.monsters["enemyTeam"][0].name+" dodges!"
		elif(move[0]):
			txt = txt + "\n" + "Critical hit!!"
	displayText(txt, "Fight")

func process_enemy_move_first(moveId):
	_enemy_move()
	yield(get_tree().create_timer(1), "timeout")
	if(state.monsters["playerTeam"][state.activeTeam[0]].currentHealth > 0):
		_ally_move(moveId)
		yield(get_tree().create_timer(1), "timeout")

func process_ally_move_first(moveId):
	_ally_move(moveId)
	yield(get_tree().create_timer(1), "timeout")
	if(state.monsters["enemyTeam"][0].currentHealth > 0):
		_enemy_move()
		yield(get_tree().create_timer(1), "timeout")

func check_speed():
	return state.monsters["playerTeam"][state.activeTeam[0]].speed >= state.monsters["enemyTeam"][0].speed

func ally_move(moveId):
	var ally_result = $Attacks.fight(state.monsters["playerTeam"][state.activeTeam[0]].moveList[moveId], state.monsters["playerTeam"][state.activeTeam[0]], state.monsters["enemyTeam"][0])
	setInfo()
	if(state.monsters["enemyTeam"][0].currentHealth == 0) :
		if(_is_enemy_team_alive()):
			yield(get_tree().create_timer(1), "timeout")
			$Textbox.hide()
			_monsters_button_pressed()
			$Monsters/Back.visible = false
		else:
			yield(get_tree().create_timer(1), "timeout")
			result = "Win"
			functions.handleXp(state.monsters["playerTeam"][state.activeTeam[0]],state.monsters["enemyTeam"][0].nextLevel)
			functions.giveGold(data.monList.result[String(state.monsters["enemyTeam"][0].id)].rarity)
			return [ally_result[0], ally_result[1]]
	else:
		return [ally_result[0], ally_result[1]]

func enemy_move(_move):
	var enemy_result = $Attacks.fight(state.monsters["playerTeam"][state.activeTeam[0]].moveList[_move], state.monsters["enemyTeam"][0],state.monsters["playerTeam"][state.activeTeam[0]]);
	setInfo()
	if(state.monsters["playerTeam"][state.activeTeam[0]].currentHealth == 0) :
		if(_is_team_alive()):
			yield(get_tree().create_timer(1), "timeout")
			$Textbox.hide()
			_monsters_button_pressed()
			$Monsters/Back.visible = false
		else:
			yield(get_tree().create_timer(1), "timeout")
			result = "Lose"
			return [enemy_result[0], enemy_result[1]]
	else:
		return [enemy_result[0], enemy_result[1]]

func use_item(index):
	var item_index = state.inventory.pop_at(index)
	var item = data.itemList.result[String(item_index)]
	var res
	if(item_index > 0 && item_index <= 3):
		res = functions.useNet(item.name)
		if res == true:
			displayText("Nice! The enemy was caught!", "Flee")
		else:
			displayText("Oh no! It broke out of your net!", "Fight")
			yield(get_tree().create_timer(1), "timeout")
			_enemy_move()
			yield(get_tree().create_timer(1), "timeout")
	if(item_index > 3 && item_index <= 7):
		#add a menu to choose which mon to heal
		functions.healMonsterPotion(0, item_index)
		setInfo()
		displayText("You used a healing potion!", "Fight")
		yield(get_tree().create_timer(1), "timeout")
		_enemy_move()
		yield(get_tree().create_timer(1), "timeout")
	return res

func _input(event):
	if(textbox_closable):
		if Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(BUTTON_LEFT) and $Textbox.visible:
			yield(get_tree().create_timer(0.25), "timeout")
			if(_landing == "Fight"):
				$Textbox.hide()
				_back_button_pressed()
				emit_signal("textbox_closed")
			elif(_landing == "Flee"):
				get_tree().change_scene("res://scenes/Game.tscn")
				clearEnemies();
				emit_signal("textbox_closed")
			else:
				get_node(_landing).show()
				$Textbox.hide()
				emit_signal("textbox_closed")

func displayText(text, landing):
	_landing = landing
	textbox_closable = false
	$Textbox/Arrow.hide()
	$Textbox.show()
	$Textbox/Label.text = text
	yield(get_tree().create_timer(1.25), "timeout")
	$Textbox/Arrow.show()
	textbox_closable = true

func _attack_button_pressed():
	$BattleMenu.hide()
	$Attacks.show()

func _monsters_button_pressed():
	$Monsters/Back.visible = true
	$Monsters.setInfo()
	if(state.monsters["playerTeam"].size() == 1):
		displayText("No monsters to switch to.", "Fight")	
	if(state.monsters["playerTeam"].size() > 1):
		$BattleMenu.hide()
		$Monsters.show()

func _back_button_pressed() :
	$Attacks.hide()
	$Items.hide()
	$Monsters.hide()
	$BattleMenu.show()

func _flee_button_pressed() :
	displayText("Got away safely", "Flee")

func clearEnemies():
	state.monsters["enemyTeam"] = {}

func setInfo():
	$Background.texture = load("res://img/backgrounds/"+String(state.currentPark)+".png")
	var ally = state.monsters["playerTeam"][state.activeTeam[0]]
	var enemy = state.monsters["enemyTeam"][0]
	$AllyHealth.max_value = ally.maxHealth
	$AllyHealth.value = int(ally.currentHealth)
	$AllyInfo.text = String(ally.level)+" "+ally.name
	$AllyType.texture = load("res://img/types/"+String(state.monsters["playerTeam"][state.activeTeam[0]].type)+".png")
	$Ally.texture = load("res://img/monsters/"+String(state.monsters["playerTeam"][state.activeTeam[0]].id)+".png")
	$EnemyHealth.max_value = int(enemy.maxHealth)
	$EnemyHealth.value = int(enemy.currentHealth)
	$EnemyInfo.text = String(enemy.level)+" "+enemy.name
	$EnemyType.texture = load("res://img/types/"+String(state.monsters["enemyTeam"][0].type)+".png")	
	$Enemy.texture = load("res://img/monsters/"+String(state.monsters["enemyTeam"][0].id)+".png")
