extends UpgradeOption

class_name ChanceFreeRoll

func _on_button_pressed():
	get_tree().get_first_node_in_group("KeyScene").chance_free_roll = true
	super()
