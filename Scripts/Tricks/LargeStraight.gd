extends PatternTrick

class_name LargeStraight


##TODO: FIX THIS
func trick_calculation() -> int:
	var dice = get_tree().get_nodes_in_group("Dice")
	
	dice.sort_custom(_compare_dice)

	for x in range(len(dice)):
			
		var consecutive_count = 0
		var last_value = dice[x].value

		for y in range(x + 1, len(dice)):
			if dice[y].value == last_value: continue

			if dice[y].value == last_value + 1:
				consecutive_count += 1

				if consecutive_count == 4:
					return 40

			else: break
			last_value = dice[y].value
			
	return 0

func _compare_dice(a, b):
	return a.value < b.value
