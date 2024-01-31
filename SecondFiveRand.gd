extends UpgradeOption

func _on_button_pressed():
	change_trick_to_fives()
	super()

func change_trick_to_fives():
	var tricks = get_tree().get_nodes_in_group("Trick")
	var trick = tricks[randi_range(0, tricks.size() - 1)]
	
	while !(trick.string_name in ["Ones", "Twos", "Threes", "Fours", "Sixes", "Sevens", "Eights", "Nines"]):
		trick = tricks[randi_range(0, tricks.size() - 1)]
	
	trick.number = 4
	trick.string_name = "Fives"
	trick.calculate()
