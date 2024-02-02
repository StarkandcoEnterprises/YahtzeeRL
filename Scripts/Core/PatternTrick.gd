extends Trick

class_name PatternTrick

func calculate():
	for die in get_tree().get_nodes_in_group("Dice"):
		if die.value == -1:
			return
	if accepted: return
	total = trick_calculation() * multiplier

func trick_calculation() -> int:
	return 0
