extends VBoxContainer

var no_of_rolls: int = 2
var current_rolls: int = 2

var score = 0
var minimum = 150


func _ready():
	roll()

func _process(_delta):
	%RollCount.text = str(current_rolls)
	%Score.text = str(score) + " / " + str(minimum)

func calculate_score():
	score = 0
	for trick in get_tree().get_nodes_in_group("Trick"):
		if trick.accepted:
			score += trick.total

func _on_roll_pressed():
	roll()
	
	current_rolls -= 1
	if current_rolls == 0:
		toggle_roll()
		toggle_visibility_of_hold()

func roll():
	for die in get_tree().get_nodes_in_group("Dice"):
		if die.held: continue
		die.roll()

func calculate_totals():
	for trick in get_tree().get_nodes_in_group("Trick"):
		trick.calculate()

func reset_rolls():
	current_rolls = no_of_rolls
	
	for die in get_tree().get_nodes_in_group("Dice"):
		if die is Dice3D: continue
		if die.held:
			die.unhold()
	
	roll()
	
	if !%Roll.disabled: return
	toggle_roll()
	toggle_visibility_of_hold()

func toggle_roll():
	%Roll.disabled = !%Roll.disabled
	
func toggle_visibility_of_hold():
	for die in get_tree().get_nodes_in_group("Dice"):
		if die is Dice3D: continue
		die.get_node("%Button").visible = !die.get_node("%Button").visible

func joker_yahtzee(yahtzee_number):
	var trick_found = false
	for trick in get_tree().get_nodes_in_group("Trick"):
		if trick.number == yahtzee_number and !trick.accepted:
			trick_found = true
			break
	if !trick_found: return
	for trick in get_tree().get_nodes_in_group("Trick"):
		if trick.number != yahtzee_number:
			trick.get_node("%Button").disabled = true

func end_joker():
	for trick in get_tree().get_nodes_in_group("Trick"):
		if !trick.accepted:
			trick.get_node("%Button").disabled = false
		if trick.string_name == "Yahtzee" and trick.state == trick.JOKER:
			trick.state = trick.MULTI_YAHTZEE

func _on_hold_first_toggled(toggled_on):
	%FirstDice.held = toggled_on


func _on_hold_second_toggled(toggled_on):
	%SecondDice.held = toggled_on


func _on_hold_third_toggled(toggled_on):
	%ThirdDice.held = toggled_on


func _on_hold_fourth_toggled(toggled_on):
	%FourthDice.held = toggled_on


func _on_hold_fifth_toggled(toggled_on):
	%FifthDice.held = toggled_on
