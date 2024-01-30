extends PatternTrick

class_name ThreeOfAKind

func trick_calculation() -> int:
	var dice = get_tree().get_nodes_in_group("Dice")
	
	var first_die
	var first_die_count = 0
	
	var new_total = 0
	
	for die in dice:
		new_total += die.value + 1
		#Set first and second dice
		if !first_die:
			first_die = die
		#Count dice
		if die.value == first_die.value:
			first_die_count += 1
	
	if first_die_count >= 3:
		return new_total
	return 0

