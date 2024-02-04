extends Node2D


func _ready():
	setInfo()

func setInfo():
	var path;
	var mon;
	var length = state.monsters["playerTeam"].size();
	
	$Mon2/Select2.disabled = false
	$Select1.disabled = false

	if(length == 2):
		$Mon2.visible = false;

	if(length > 1):
		path = "res://img/monsters/"+String(state.monsters["playerTeam"][state.activeTeam[1]].id)+".png"
		$Type1.texture = load("res://img/types/"+String(state.monsters["playerTeam"][state.activeTeam[1]].type)+".png")
		$Mon1.texture = load(path)
		mon = state.monsters["playerTeam"][state.activeTeam[1]]
		$ProgressBar.max_value = mon.maxHealth
		$ProgressBar.value = mon.currentHealth
		$Label.text =(mon.name+"\n"+String(mon.type))
		if(mon.currentHealth == 0):
			$Select1.disabled = true

	if(length > 2):
		$Mon2.visible = true;
		path = "res://img/monsters/"+String(state.monsters["playerTeam"][state.activeTeam[2]].id)+".png"
		$Mon2/Type2.texture = load("res://img/types/"+String(state.monsters["playerTeam"][state.activeTeam[2]].type)+".png")		
		$Mon2/Mon2.texture = load(path)
		mon = state.monsters["playerTeam"][state.activeTeam[2]]
		$Mon2/ProgressBar2.max_value = mon.maxHealth
		$Mon2/ProgressBar2.value = mon.currentHealth
		$Mon2/Label2.text =(mon.name+"\n"+String(mon.type))
		if(mon.currentHealth == 0):
			$Mon2/Select2.disabled = true
