extends PatternTrick

class_name FourOfAKind


func trick_calculation() -> int:
	var dice = get_tree().get_nodes_in_group("Dice")
	
	var die_array = {}
	
	var new_total = 0
	
	for die in dice:
		new_total += die.value + 1
		
		if !die_array.has(die.value):
			die_array[die.value] = 1
		else:
			die_array[die.value] += 1
			
	for die_value in die_array:
		if die_array[die_value] >= 4:
			return new_total
			
	return 0

