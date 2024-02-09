extends Trick

class_name PatternTrick

func calculate():
	if accepted: return
	for die in get_tree().get_nodes_in_group("Dice"):
		if die.value == -1:
			total = 0
			return
	total = trick_calculation() * multiplier

func trick_calculation() -> int:
	return 0
