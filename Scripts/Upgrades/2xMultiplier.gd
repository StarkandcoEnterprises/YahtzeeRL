extends UpgradeOption

func _on_button_pressed():
	update_multiplier()
	get_tree().get_first_node_in_group("KeyScene").reset_rolls()
	super()

func update_multiplier():
	for trick in get_tree().get_nodes_in_group("Trick"):
		trick.multiplier = 2
