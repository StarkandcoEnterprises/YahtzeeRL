extends Node2D

var games_complete = 1

var all_upgrades = [preload("res://Scenes/Upgrades/Change1to7.tscn").instantiate(), \
preload("res://Scenes/Upgrades/Change2to8.tscn").instantiate(), preload("res://Scenes/Upgrades/Change3to9.tscn").instantiate()]
var upgrades: Array

func continue_game():
	for trick in get_tree().get_nodes_in_group("Trick"):
		if !trick.accepted: return true
	return false

func game_over():
	$KeyGameScene.current_rolls = 0
	toggle_dice_roll_buttons()
	$KeyGameScene.toggle_roll()
	
	var score = calculate_final_score()
	
	if score <= $KeyGameScene.minimum:
		%FinalScore.text = "Final Score: " + str(score)
		%EndGamePanel.visible = true
		games_complete = 1
		$KeyGameScene.minimum = 150
	else:
		$KeyGameScene.score = 0
		$KeyGameScene.minimum += 50 * games_complete
		
		var number_of_upgrades = 3
		
		if !upgrades:
			upgrades = all_upgrades.duplicate()
		
		if upgrades.size() < 3: number_of_upgrades = upgrades.size()
		
		for x in number_of_upgrades:
			%UpgradePanel.get_child(0).add_child(upgrades.pop_at(randi_range(0, upgrades.size() - 1)))
		
		%UpgradePanel.visible = true
		_on_new_game_pressed()
		games_complete += 1

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
	$KeyGameScene.score = 0
	$KeyGameScene.reset_rolls()
	toggle_dice_roll_buttons()

func toggle_dice_roll_buttons():
	for die: Dice in get_tree().get_nodes_in_group("Dice"):
		die.get_node("%Button").disabled = !die.get_node("%Button").disabled
