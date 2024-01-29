extends Node2D

var no_of_rolls: int = 2
var current_rolls: int = 2

func _ready():
	roll_and_total()

func _process(_delta):
	%RollCount.text = str(current_rolls)

func _on_button_pressed():
	roll_and_total()
	
	current_rolls -= 1
	if current_rolls == 0:
		%Roll.disabled = true

func roll_and_total():
	roll()
	calculate_totals()

func roll():
	for die: Dice in get_tree().get_nodes_in_group("Dice"):
		if die.held: continue
		die.roll()

func calculate_totals():
	for trick in get_tree().get_nodes_in_group("Trick"):
		if trick.accepted: continue
		trick.calculate()

func reset_rolls():
	current_rolls = no_of_rolls
	
	for die: Dice in get_tree().get_nodes_in_group("Dice"):
		if die.held:
			die.unhold()
	
	roll_and_total()
	
	%Roll.disabled = false

func continue_game():
	for trick in get_tree().get_nodes_in_group("Trick"):
		if !trick.accepted: return true
	return false

func game_over():
	current_rolls = 0
	toggle_dice_roll_buttons()
	
	%Roll.disabled = true
	
	var score = calculate_final_score()
	
	%FinalScore.text = "Final Score: " + str(score)
	%FinalScore.visible = true
	%NewGame.visible = true

func calculate_final_score() -> int:
	var final_score = 0
	for trick in get_tree().get_nodes_in_group("Trick"):
		final_score += trick.total
	return final_score

func reset_tricks():
	for trick in get_tree().get_nodes_in_group("Trick"):
		trick.accepted = false
		trick.get_node("%Button").disabled = false

func _on_new_game_pressed():
	%FinalScore.visible = false
	%NewGame.visible = false
	reset_tricks()
	reset_rolls()
	toggle_dice_roll_buttons()

func toggle_dice_roll_buttons():
	for die: Dice in get_tree().get_nodes_in_group("Dice"):
		die.get_node("%Button").disabled = !die.get_node("%Button").disabled
