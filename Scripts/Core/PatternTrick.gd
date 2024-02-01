extends Trick

class_name PatternTrick

func calculate():
	if accepted: return
	total = trick_calculation() * multiplier

func trick_calculation() -> int:
	return 0
