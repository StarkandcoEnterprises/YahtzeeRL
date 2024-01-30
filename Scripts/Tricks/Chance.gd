extends PatternTrick

class_name Chance

func trick_calculation() -> int:
	var dice = get_tree().get_nodes_in_group("Dice")
	
	total = 0
	
	for die in dice:
		total += die.value + 1
	
	return total

