extends PatternTrick

class_name Yahtzee

var yahtzee = false
var complete = false

func calculate():
	if accepted and !yahtzee: return
	elif yahtzee and complete: return
	if determine_yahtzee():
		%Button.disabled = false
	elif yahtzee and !complete:
		%Button.disabled = true
	total = trick_calculation()

func determine_yahtzee():
	var dice = get_tree().get_nodes_in_group("Dice")
	
	var first_die
	var first_die_count = 0
	
	for die in dice:
		#Set first and second dice
		if !first_die:
			first_die = die
		#Count dice
		if die.value == first_die.value:
			first_die_count += 1
	return first_die_count == 5

func trick_calculation():
	if determine_yahtzee():
		if total == 0 or !yahtzee:
			return 50
		elif yahtzee:
			return 150
	elif yahtzee:
		return 50
	return 0


func _on_button_pressed():
	if total == 50:
		accepted = true
		yahtzee = true
		%Button.disabled = true
	elif total == 150:
		complete = true
		%Button.disabled = true
	else:
		accepted = true
		%Button.disabled = true

	game.get_node("KeyGameScene").calculate_score()
	
	if game.continue_game():
		game.get_node("KeyGameScene").reset_rolls()
	else:
		game.game_over()
