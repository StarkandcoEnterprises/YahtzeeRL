extends VBoxContainer

var no_of_rolls: int = 2
var current_rolls: int = 2

func _ready():
	roll_and_total()

func _process(_delta):
	%RollCount.text = str(current_rolls)

func _on_roll_pressed():
	roll_and_total()
	
	current_rolls -= 1
	if current_rolls == 0:
		toggle_roll()
		toggle_visibility_of_hold()

func roll_and_total():
	roll()
	calculate_totals()

func roll():
	for die: Dice in get_tree().get_nodes_in_group("Dice"):
		if die.held: continue
		die.roll()

func calculate_totals():
	for trick in get_tree().get_nodes_in_group("Trick"):
		trick.calculate()

func reset_rolls():
	current_rolls = no_of_rolls
	
	for die: Dice in get_tree().get_nodes_in_group("Dice"):
		if die.held:
			die.unhold()
	
	roll_and_total()
	
	if !%Roll.disabled: return
	toggle_roll()
	toggle_visibility_of_hold()

func toggle_roll():
	%Roll.disabled = !%Roll.disabled
	
func toggle_visibility_of_hold():
	for die in get_tree().get_nodes_in_group("Dice"):
		die.get_node("%Button").visible = !die.get_node("%Button").visible
