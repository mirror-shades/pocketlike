extends Node2D

func _ready():
	build_menu()

func build_menu():
	$Items.get_popup().clear()
	for item in range(state.inventory.size()):
		$Items.get_popup().add_item(data.itemList.result[String(state.inventory[item])].name,item)
