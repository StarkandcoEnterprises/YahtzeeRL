extends PatternTrick

class_name FullHouse

func trick_calculation() -> int:
	var dice = get_tree().get_nodes_in_group("Dice")
	
	var first_die
	var first_die_count = 0
	var second_die
	var second_die_count = 0
	
	for die in dice:
		#Set first and second dice
		if !first_die:
			first_die = die
		elif !second_die and die.value != first_die.value:
			second_die = die
		
		#Count dice
		if die.value == first_die.value:
			first_die_count += 1
		elif second_die:
			if die.value == second_die.value:
				second_die_count += 1
	
	if (first_die_count == 3 and second_die_count == 2) or (first_die_count == 2 and second_die_count == 3):
		return 30
	return 0
