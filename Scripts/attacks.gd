extends Node2D

var battle = load("res://Scripts/battle.gd")
var rng = RandomNumberGenerator.new()

func _ready():
	var b1 = $Attack1
	var b2 = $Attack2
	var b3 = $Attack3
	var b4 = $Attack4
	var ally = state.monsters["playerTeam"][state.activeTeam[0]]
	if (ally.moveList.size() > 0):
		b1.disabled = false
		var move = String(ally.moveList[0])
		b1.text = data.moveList.result[move].name
	if (ally.moveList.size() > 1):
		b2.disabled = false
		var move = String(ally.moveList[1])
		b2.text = data.moveList.result[move].name
	if (ally.moveList.size() > 2):
		b3.disabled = false
		var move = String(ally.moveList[2])
		b3.text = data.moveList.result[move].name
	if (ally.moveList.size() > 3):
		b4.disabled = false
		var move = String(ally.moveList[3])
		b4.text = data.moveList.result[move].name
 
func fight(moveId, first, second):
	var effectiveness = checkEffectiveness(data.moveList.result[String(moveId)].type, second.type);
	var crit = checkCrit(first.speed, second.speed);
	var dodge = checkDodge(first.speed, second.speed);
	var attackPower;
	var didDodge = false
	var didCrit = false
	if (data.moveList.result[String(moveId)].special == true):
		attackPower = first.special;
	else:
		attackPower = first.attack;
	var damage = ((((2 * first.level) / 6 + 2) * int(data.moveList.result[String(moveId)].power) * attackPower) / second.defence / 50 + 2) * crit * effectiveness * dodge
	if (dodge == 1):
		damage = moveEffect(data.moveList.result[String(moveId)].effect, damage, first.currentHealth, second.currentHealth);
		damage = int(damage);
	if (second.currentHealth - damage < 0):
		second.currentHealth = 0;
	else:
		second.currentHealth = second.currentHealth - damage
	if(dodge == 0):
		didDodge = true;
	elif(crit > 1):
		didCrit = true
	return [didCrit, didDodge];

func checkEffectiveness(friendlyType, foeType):  
	var mod = 1;
	if (friendlyType  == "fire" ):  
		if (foeType  == "earth" ):  
			mod = 1.5;
		if (foeType  == "fighting" ):  
			mod = 1.5;
		if (foeType  == "dragon" ):  
			mod = 0.5;
		if (foeType  == "water" ):  
			mod = 0.5;
		if (foeType  == "fire" ):  
			mod = 0.5;

	if (friendlyType  == "water" ):  
		if (foeType  == "fire" ):  
			mod = 1.5;
		if (foeType  == "psychic" ):  
			mod = 1.5;
		if (foeType  == "electric" ):  
			mod = 0.5;
		if (foeType  == "air" ):  
			mod = 0.5;
		if (foeType  == "water" ):  
			mod = 0.5;

	if (friendlyType  == "earth" ):  
		if (foeType  == "air" ):  
			mod = 1.5;
		if (foeType  == "electric" ):  
			mod = 1.5;
		if (foeType  == "fighting" ):  
			mod = 0.5;
		if (foeType  == "fire" ):  
			mod = 0.5;
		if (foeType  == "earth" ):  
			mod = 0.5;

	if (friendlyType  == "air" ):  
		if (foeType  == "water" ):  
			mod = 1.5;
		if (foeType  == "dragon" ):  
			mod = 1.5;
		if (foeType  == "psychic" ):  
			mod = 0.5;
		if (foeType  == "earth" ):  
			mod = 0.5;
		if (foeType  == "air" ):  
			mod = 0.5;

	if (friendlyType  == "divine" ):  
		if (foeType  == "water" ):  
			mod = 1.5;
		if (foeType  == "demonic" ):  
			mod = 1.5;
		if (foeType  == "electric" ):  
			mod = 1.5;
		if (foeType  == "eldritch" ):  
			mod = 0.5;
		if (foeType  == "divine" ):  
			mod = 0.5;

	if (friendlyType  == "eldritch" ):  
		if (foeType  == "air" ):  
			mod = 1.5;
		if (foeType  == "divine" ):  
			mod = 1.5;
		if (foeType  == "fighting" ):  
			mod = 1.5;
		if (foeType  == "cybernetic" ):  
			mod = 0.5;
		if (foeType  == "eldrich" ):  
			mod = 0.5;

	if (friendlyType  == "demonic" ):  
		if (foeType  == "fire" ):  
			mod = 1.5;
		if (foeType  == "cybernetic" ):  
			mod = 1.5;
		if (foeType  == "dragon" ):  
			mod = 1.5;
		if (foeType  == "divine" ):  
			mod = 0.5;
		if (foeType  == "demonic" ):  
			mod = 0.5;

	if (friendlyType  == "cybernetic" ):  
		if (foeType  == "earth" ):  
			mod = 1.5;
		if (foeType  == "eldritch" ):  
			mod = 1.5;
		if (foeType  == "psychic" ):  
			mod = 1.5;
		if (foeType  == "demonic" ):  
			mod = 0.5;
		if (foeType  == "cybernetic" ):  
			mod = 0.5;

	if (friendlyType  == "fighting" ):  
		if (foeType  == "divine" ):  
			mod = 1.5;
		if (foeType  == "cybernetic" ):  
			mod = 1.5;
		if (foeType  == "fighting" ):  
			mod = 1.5;
		if (foeType  == "electric" ):  
			mod = 1.5;
		if (foeType  == "psychic" ):  
			mod = 0.5;
		if (foeType  == "fire" ):  
			mod = 0.5;

	if (friendlyType  == "psychic" ):  
		if (foeType  == "demonic" ):  
			mod = 1.5;
		if (foeType  == "eldritch" ):  
			mod = 1.5;
		if (foeType  == "psychic" ):  
			mod = 1.5;
		if (foeType  == "dragon" ):  
			mod = 1.5;
		if (foeType  == "air" ):  
			mod = 0.5;
		if (foeType  == "fighting" ):  
			mod = 0.5;

	if (friendlyType  == "dragon" ):  
		if (foeType  == "divine" ):  
			mod = 1.5;
		if (foeType  == "eldritch" ):  
			mod = 1.5;
		if (foeType  == "dragon" ):  
			mod = 1.5;
		if (foeType  == "psychic" ):  
			mod = 1.5;
		if (foeType  == "air" ):  
			mod = 0.5;
		if (foeType  == "electric" ):  
			mod = 0.5;
	
	if (friendlyType  == "electric" ):  
		if (foeType  == "demonic" ):  
			mod = 1.5;
		if (foeType  == "cybernetic" ):  
			mod = 1.5;
		if (foeType  == "fighting" ):  
			mod = 1.5;
		if (foeType  == "electric" ):  
			mod = 1.5;
		if (foeType  == "water" ):  
			mod = 0.5;
		if (foeType  == "dragon" ):  
			mod = 0.5;
	return mod;

func checkCrit(firstSpeed, secondSpeed):
	var mod = 1;
	if (firstSpeed * 2 > secondSpeed):
		var critChance = (firstSpeed * 2 - secondSpeed) / 2;
		var critCheck =  rng.randi_range(1, 255);
		if (critChance > critCheck):
			mod = 1.5;
	return mod;

func moveEffect(effectId, damage, hp1, hp2):
	var randNum =  rng.randi_range(1, 12);
	if (randNum > 6):
		if (effectId == "1"):
			state.monsters["enemyTeam"][0].status = "paralyzed"; 
		if (effectId == "2"):
			state.monsters["enemyTeam"][0].status = "burn"; 
		if (effectId == "3"):
			state.monsters["enemyTeam"][0].status = "sleep"; 
		if (effectId == "4"):
			state.monsters["enemyTeam"][0].status = "poison"; 
	if (effectId == "5"):
		pass #recoil 
	if (effectId == "6"):
		pass #spcUp 
	if (effectId == "7"):
		pass #attackUp 
	if (effectId == "8"):
		pass #speedUp 
	if (effectId == "9"):
		pass #defup 
	if (effectId == "10"):
		pass #amplify, speed up greatly, special down 
	if (effectId == "11"):
		pass #infuse, attack up greatly, defense down 
	if (effectId == "12"):
		pass #dispensation, defense up greatly, attack down 
	if (effectId == "13"):
		pass #madness, special up greatly, speed down 
	if (effectId == "14"):
		pass #heal 
	if (effectId == "15"):
		pass #donation, bonus gold 
	if (effectId == "16"):
		pass #become, become a copy of the enemy 
	if (effectId == "17"):
		pass #panic, foe uses random move 
	if (effectId == "18"):
		pass #standby, deal damage then switch monsters 
	if (effectId == "19"):
		pass #firewall, foe cannot use last attack 
	if (effectId == "20"):
		pass #scare, wild enemy flees 
	if (effectId == "21"):
		pass #damage, switches enemy 
	if (effectId == "22"):
		pass #deathblow, kill self, enemy dies in 2 turns 
	if (effectId == "23"):
		damage = hp2 / 2; 
	if (effectId == "24"):
		damage = hp1 / 2; 
	return damage; 

func checkDodge(firstSpeed, secondSpeed):
	var mod = 1;
	if (firstSpeed * 2 > secondSpeed):
		var dodgeChance = (firstSpeed * 2 - secondSpeed) / 2;
		var dodgeCheck =  rng.randi_range(1, 255);
		if (dodgeChance > dodgeCheck):
			mod = 0;
	return mod;
 
