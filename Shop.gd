extends Node2D


var _text;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Money.text = "Gold: %s" % String(state.gold)
	
	$Panel1/Label.text = String(data.itemList.result["4"].price) + " gold"
	$Panel1/Label2.text = String(data.itemList.result["1"].price) + " gold"
	
	$Panel1/Item1.connect("mouse_entered", self, "_on_btn_mouse_entered", [4])
	$Panel1/Item1.connect("mouse_exited", self, "_on_btn_mouse_exited")
	$Panel1/Item2.connect("mouse_entered", self, "_on_btn_mouse_entered", [1])
	$Panel1/Item2.connect("mouse_exited", self, "_on_btn_mouse_exited")
	$Panel1/Item3.connect("mouse_entered", self, "_on_btn_mouse_entered", [3])
	$Panel1/Item3.connect("mouse_exited", self, "_on_btn_mouse_exited")
	$Panel1/Item4.connect("mouse_entered", self, "_on_btn_mouse_entered", [4])
	$Panel1/Item4.connect("mouse_exited", self, "_on_btn_mouse_exited")
	
	$Panel1/Item1.connect("pressed", self, "_buy_item", [4]);
	$Panel1/Item2.connect("pressed", self, "_buy_item", [1]);
	$Panel1/Item3.connect("pressed", self, "_buy_item", [3]);
	$Panel1/Item4.connect("pressed", self, "_buy_item", [4]);
	
	$Back.connect("pressed", self, "_back_button_pressed")
	$Inventory.connect("pressed", self, "_inventory_button_pressed")	

func _back_button_pressed():
	get_tree().change_scene("res://scenes/Game.tscn")

func _inventory_button_pressed():
	get_tree().change_scene("res://scenes/Inventory.tscn")

func _on_btn_mouse_entered(id):
	$Textbox/Panel/Label.text = data.itemList.result[String(id)].description
	get_node("Textbox").show()

func _on_btn_mouse_exited():
	get_node("Textbox").hide()

func _buy_item(id):
	var price = data.itemList.result[String(id)].price
	print(price)
	if(price <= state.gold):
		state.gold = state.gold - price
		state.inventory.append(id)
		$Money.text = "Gold: %s" % String(state.gold)

