extends Node

var rng = RandomNumberGenerator.new()

func craftParkMonster():
	rng.randomize()
	var r = rng.randi_range(1, state.parkList[state.currentPark].size());
	var _min = 3;
	var _max = 6;
	if(state.currentPark == "Crumpled Mountain"):
		_min = 12
		_max = 16
	if(state.currentPark == "Shaggy Plains"):
		_min = 20
		_max = 26
	if(state.currentPark == "Soggy Mines"):
		_min = 30
		_max = 38
	if(state.currentPark == "National Park"):
		_min = 42
		_max = 50
	var n = rng.randi_range(_min, _max);
	craftMonster("enemyTeam", state.parkList[state.currentPark][r - 1], n);

func switch_mon(id):
	var _mon = state.activeTeam.pop_at(id)
	state.activeTeam.push_front(_mon)

func healMonsterPotion(index, potion):
	var healingPoints = 20
	if(state.monsters["playerTeam"][index].currentHealth + healingPoints > state.monsters["playerTeam"][index].maxHealth):
		state.monsters["playerTeam"][index].currentHealth = state.monsters["playerTeam"][index].maxHealth
	else:
		state.monsters["playerTeam"][index].currentHealth = state.monsters["playerTeam"][index].currentHealth + healingPoints

func healAll():
	for i in state.monsters["playerTeam"]:
		state.monsters["playerTeam"][state.activeTeam[i]].currentHealth = state.monsters["playerTeam"][state.activeTeam[i]].maxHealth;

func craftMonster(location, id, level):
	rng.randomize()
	var baseMon = data.monList.result[str(id)];
	var index = state.monsters[location].size();
	var _maxHealth = 5 + baseMon.healthMod + rng.randi_range(1, baseMon.healthMod + 3);
	var _currentHealth = _maxHealth;
	var _attack = 2 + baseMon.attackMod + rng.randi_range(1, baseMon.attackMod + 1);
	var _defence = 2 + baseMon.defenceMod + rng.randi_range(1, baseMon.defenceMod + 1);
	var _speed = 2 + baseMon.speedMod + rng.randi_range(1, baseMon.speedMod + 1);
	var _special = 2 + baseMon.specialMod + rng.randi_range(1, baseMon.specialMod + 1);
	var _nextLevel = 5 + baseMon.rarity;
	state.monsters[location][index] = {"name": baseMon.name,"id": id, "type": baseMon.type, "monsterNumber": index, "level": 1, "maxHealth": baseMon.healthMod, "currentHealth": baseMon.healthMod, "attack": baseMon.attackMod, "defence": baseMon.defenceMod, "speed": baseMon.speedMod, "special": baseMon.specialMod, "currentXp": 0, "nextLevel": baseMon.rarity, "evolve": baseMon.evolve, "moveList": {},}
	while (state.monsters[location][index].level < level):
		state.monsters[location][index] = levelUp(state.monsters[location][index])
	if(state.activeTeam.size() < 3):
		state.activeTeam.append(index)

func levelUp(monster):
	rng.randomize()	
	var mon = monster
	var monMod = data.monList.result[str(mon.id)];
	var newLevel = String(mon.level + 1)
	if newLevel in monMod.moveList:
		var _move = monMod.moveList[newLevel]
		mon.moveList[mon.moveList.size()] = _move
	if (mon.evolve != 0 && mon.level + 1 >= mon.evolve):
		mon = evolve(mon);
	var origHealth = mon.maxHealth;
	mon.maxHealth = mon.maxHealth + rng.randi_range(1, monMod.healthMod) + monMod.healthMod;
	var newHealth = mon.maxHealth;
	var diff = newHealth - origHealth;
	if (mon.currentHealth < newHealth):
		if (newHealth - mon.currentHealth >= diff):
			mon.currentHealth = mon.currentHealth + diff;
	else:
		mon.currentHealth = newHealth;
	mon = _handleBaseStats(mon, monMod);
	mon.nextLevel = mon.nextLevel + mon.nextLevel / 4 + 5;
	mon.nextLevel = int(mon.nextLevel);
	mon.level = mon.level + 1;
	return mon;

func _handleBaseStats(_monster, monMod):
	rng.randomize()	
	var res = _monster;
	res.attack = _monster.attack + rng.randi_range(1, monMod.attackMod + monMod.attackMod);
	res.defence = _monster.defence + rng.randi_range(1, monMod.defenceMod + monMod.defenceMod);
	res.speed = _monster.speed + rng.randi_range(1, monMod.speedMod + monMod.speedMod);
	res.special = _monster.special + rng.randi_range(1, monMod.specialMod + monMod.specialMod);
	return res;

func evolve(mon):	
	var monMod = data.monList.result[str(mon.id + 1)];
	var init = mon.id;
	var evo = init + 1;
	mon.id = evo;
	mon.name = monMod.name;
	mon.rarity = monMod.rarity;
	mon.evolve = monMod.evolve;
	return mon;

func buff(mon, type, buff):
	if (type == "strength"):
		mon.attack = mon.attack + buff;
	if (type == "defence"):
		mon.defence = mon.defence + buff;
	if (type == "speed"):
		mon.speed = mon.speed + buff;
	if (type == "special"):
		mon.special = mon.special + buff;
	if (type == "hp"):
		mon.maxHealth = mon.maxHealth + buff;
		mon.currentHealth = mon.maxHealth;
	return mon

func advanceStage():
	print(state.currentTown)
	if (state.currentTown == "Hyac Island"):
		state.currentTown = "Hemlopolis"
		state.currentPark ="National Park"
	if (state.currentTown == "Lily City"):
		state.currentTown = "Hyac Island"
		state.currentPark ="Soggy Mines"
	if (state.currentTown == "Daffow Hills"):
		state.currentTown = "Lily City"
		state.currentPark ="Shaggy Plains"
	if (state.currentTown == "Roseville"):
		state.currentTown = "Daffow Hills"
		state.currentPark ="Crumpled Mountain"
	get_tree().reload_current_scene()

func handleXp(mon, xp):
	rng.randomize()
	var _levels = 0;
	var _level = mon.level;
	var _currentXp = mon.currentXp;
	_currentXp = _currentXp + xp;
	while (_currentXp >= mon.nextLevel):
		_currentXp = _currentXp - mon.nextLevel;
		mon = levelUp(mon);
		_levels = _levels + 1;
	mon.currentXp = _currentXp;

func giveGold(rarity):
	var _gold = rng.randi_range(rarity * 2, rarity * 3)
	state.gold = _gold + state.gold

func catchEnemy(_enemy, _netQuality):
	rng.randomize()
	var difficulty = 100;
	var netMod;
	if (_netQuality == "Butterfly Net") :
		netMod = 20;

	if (_netQuality == "Fish Net") :
		netMod = 40;

	if (_netQuality == "Elephant Net") :
		netMod = 60;

	#take % of hp, at 1% hpleft should equal 25, scaling to 0 at 100%
	var hpLeft = 0;
	var x = int(_enemy.maxHealth);
	var y = int(_enemy.currentHealth);
	var perc = y / x;
	perc = perc * 100;
	perc = 100 - perc;
	hpLeft = int(perc / 4);
	#if any immobilizng status changes, change to 15
	var statusChange = 0;
	#lower difficulty =  easier catch
	difficulty = difficulty - (hpLeft * 2 + statusChange + netMod);
	#factor rarity into difficulty
	difficulty = difficulty + 4 * data.monList.result[String(state.monsters["enemyTeam"][0].id)].rarity;
	#checks difficulty to ensure a 1% catch chance minimum
	if (difficulty > 99) :
		difficulty = 99;
	if (difficulty < 1) :
		difficulty = 1;
	#rolls random # out of 100 and checks if it's larger than the difficulty rating
	var roll = rng.randi_range(1, 100);
	if (roll > difficulty) :
		#successful catch
		state.monsters["playerTeam"][state.monsters["playerTeam"].size()] = state.monsters["enemyTeam"][0]
		return true
	else :
		return false;

func useNet(type):
	var res = catchEnemy(state.monsters["enemyTeam"][0], type);
	return res

func encounterMonster():
	rng.randomize()
	var n = rng.randi_range(1, 100);
	if (n > 90):
		craftParkMonster()
		get_tree().change_scene("res://scenes/Battle.tscn")
