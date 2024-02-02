extends VBoxContainer

var no_of_rolls: int = 2
var current_rolls: int = 2

var score = 0
var minimum = 150


func _ready():
	roll()

var counter = 0

func _process(_delta):
	counter += 1
	%RollCount.text = str(current_rolls)
	%Score.text = str(score) + " / " + str(minimum)
	if counter % 2 == 0:
		calculate_totals()

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
		toggle_hold()

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
		if die.held:
			die.held = false
	
	roll()
	
	if !%Roll.disabled: return
	toggle_roll()
	toggle_hold()

func toggle_roll():
	%Roll.disabled = !%Roll.disabled
	
func toggle_hold():
	for button in $HoldButtons.get_children():
		button.disabled = !button.disabled
		if button.disabled == false:
			button.button_pressed = false

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
	$Dice3D/DiceContainer.get_node("%Dice").held = toggled_on


func _on_hold_second_toggled(toggled_on):
	$Dice3D/DiceContainer2.get_node("%Dice").held = toggled_on


func _on_hold_third_toggled(toggled_on):
	$Dice3D/DiceContainer3.get_node("%Dice").held = toggled_on


func _on_hold_fourth_toggled(toggled_on):
	$Dice3D/DiceContainer4.get_node("%Dice").held = toggled_on


func _on_hold_fifth_toggled(toggled_on):
	$Dice3D/DiceContainer5.get_node("%Dice").held = toggled_on
