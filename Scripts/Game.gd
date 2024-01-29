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
