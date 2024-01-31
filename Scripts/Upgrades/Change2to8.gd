extends UpgradeOption

class_name ChangeTwoToEight

func _on_button_pressed():
	change_trick()
	change_dice()
	get_tree().get_first_node_in_group("Game").get_node("KeyGameScene").reset_rolls()
	super()

func change_trick():
	for trick in get_tree().get_nodes_in_group("Trick"):
		if trick.string_name == "Twos":
			trick.number = 7
			trick.string_name = "Eights"
			return

func change_dice():
	for die in get_tree().get_nodes_in_group("Dice"):
		if die.possible_values.find(1) != -1:
			die.possible_values.insert(die.possible_values.find(1), 7)
			die.possible_values.remove_at(die.possible_values.find(1))
