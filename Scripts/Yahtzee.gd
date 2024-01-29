extends PatternTrick

class_name Yahtzee

func trick_calculation():
	var dice = get_tree().get_nodes_in_group("Dice")
	
	var first_die
	var first_die_count = 0
	
	for die in dice:
		#Set first and second dice
		if !first_die:
			first_die = die
		#Count dice
		if die.value == first_die.value:
			first_die_count += 1
	
	if first_die_count == 5:
		return 50
	return 0
