extends UpgradeOption

class_name ChangeThreeToNine

func _on_button_pressed():
	super()
	change_tricks()
	change_dice()
	get_tree().get_first_node_in_group("Game").get_node("KeyGameScene").reset_rolls()

func change_tricks():
	for trick in get_tree().get_nodes_in_group("Trick"):
		if trick.string_name == "Threes":
			trick.number = 8
			trick.string_name = "Nines"

func change_dice():
	for die in get_tree().get_nodes_in_group("Dice"):
		if die.possible_values.find(2) != -1:
			die.possible_values.insert(die.possible_values.find(2), 8)
			die.possible_values.remove_at(die.possible_values.find(2))
