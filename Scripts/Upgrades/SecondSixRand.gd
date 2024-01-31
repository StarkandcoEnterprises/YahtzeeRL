extends UpgradeOption

func _on_button_pressed():
	change_trick_to_sixes()
	super()

func change_trick_to_sixes():
	var tricks = get_tree().get_nodes_in_group("Trick")
	var trick = tricks[randi_range(0, tricks.size() - 1)]
	
	while !(trick.string_name in ["Ones", "Twos", "Threes", "Fours", "Fives", "Sevens", "Eights", "Nines"]):
		trick = tricks[randi_range(0, tricks.size() - 1)]
	
	trick.number = 5
	trick.string_name = "Sixes"
	trick.calculate()
