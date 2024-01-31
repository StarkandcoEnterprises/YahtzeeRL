extends UpgradeOption

func _on_button_pressed():
	change_trick_to_fours()
	super()

func change_trick_to_fours():
	var tricks = get_tree().get_nodes_in_group("Trick")
	var trick = tricks[randi_range(0, tricks.size() - 1)]
	
	while !(trick.string_name in ["Ones", "Twos", "Threes", "Fives", "Sixes", "Sevens", "Eights", "Nines"]):
		trick = tricks[randi_range(0, tricks.size() - 1)]
	
	trick.number = 3
	trick.string_name = "Fours"
	trick.calculate()
