extends Node2D

func continue_game():
	for trick in get_tree().get_nodes_in_group("Trick"):
		if !trick.accepted: return true
	return false

func game_over():
	$KeyGameScene.current_rolls = 0
	toggle_dice_roll_buttons()
	
	$KeyGameScene.toggle_roll()
	
	var score = calculate_final_score()
	
	%FinalScore.text = "Final Score: " + str(score)
	%EndGamePanel.visible = true

func calculate_final_score() -> int:
	var final_score = 0
	for trick in get_tree().get_nodes_in_group("Trick"):
		final_score += trick.total
	return final_score

func reset_tricks():
	for trick in get_tree().get_nodes_in_group("Trick"):
		trick.accepted = false
		trick.get_node("%Button").disabled = false
		if trick is Yahtzee:
			trick.yahtzee = false
			trick.complete = false

func _on_new_game_pressed():
	%EndGamePanel.visible = false
	reset_tricks()
	$KeyGameScene.reset_rolls()
	toggle_dice_roll_buttons()

func toggle_dice_roll_buttons():
	for die: Dice in get_tree().get_nodes_in_group("Dice"):
		die.get_node("%Button").disabled = !die.get_node("%Button").disabled
