extends PatternTrick

class_name Yahtzee

enum {UNSCORED, ZERO_SCORED, YAHTZEE, MULTI_YAHTZEE, JOKER}
var state = UNSCORED
var yahtzees_scored = 0
var first_die

func calculate():
	if state == ZERO_SCORED: return
	if (state in [YAHTZEE, MULTI_YAHTZEE] and determine_yahtzee()) or state == UNSCORED:
		%Button.disabled = false
	else:
		%Button.disabled = true
	total = trick_calculation()

func determine_yahtzee():
	var dice = get_tree().get_nodes_in_group("Dice")
	
	first_die = null
	var first_die_count = 0
	
	for die in dice:
		if !first_die:
			first_die = die
		if die.value == first_die.value:
			first_die_count += 1
	return first_die_count == 5

func trick_calculation():
	if determine_yahtzee():
		return 50 + (100 * (yahtzees_scored))
	elif state == YAHTZEE: return 50
	elif state == MULTI_YAHTZEE: return 50 + (100 * (yahtzees_scored - 1))
	elif state in [UNSCORED, ZERO_SCORED]: return 0


func _on_button_pressed():
	var game = get_tree().get_first_node_in_group("KeyScene")
	if determine_yahtzee():
		yahtzees_scored += 1
		if state == YAHTZEE:
			state = MULTI_YAHTZEE
		if state == UNSCORED:
			state = YAHTZEE
	else:
		state = ZERO_SCORED
	accepted = true
	%Button.disabled = true
	
	game.calculate_score()
	if state != MULTI_YAHTZEE:
		if get_tree().get_first_node_in_group("Game").continue_game():
			game.reset_rolls()
		else:
			get_tree().get_first_node_in_group("Game").game_over()
	else:
		state = JOKER
		game.joker_yahtzee(first_die.value)
