extends UpgradeOption

func _on_button_pressed():
	add_roll()
	get_tree().get_first_node_in_group("KeyScene").reset_rolls()
	super()

func add_roll():
	get_tree().get_first_node_in_group("KeyScene").no_of_rolls = 3
