extends PatternTrick

class_name LargeStraight

func trick_calculation() -> int:
	var dice = get_tree().get_nodes_in_group("Dice")
	
	dice.sort_custom(_compare_dice)

	var consecutive_count = 0

	for i in range(len(dice) - 1):
		if dice[i].value + 1 == dice[i + 1].value:
			consecutive_count += 1
			if consecutive_count == 4:
				return 40
		else:
			consecutive_count = 0
	return 0

func _compare_dice(a, b):
	return a.value < b.value
