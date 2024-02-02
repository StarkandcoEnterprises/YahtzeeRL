extends HBoxContainer

class_name Trick

@export var number = 0
@export var string_name = "Ones"

var accepted = false
var total = 0
var multiplier = 1

func _ready():
	%Label.text = string_name

func _process(_delta):
	%TrickTotal.text = str(total)
	%Label.text = string_name

func calculate():
	if accepted: return
	total = 0
	for die in get_tree().get_nodes_in_group("Dice"):
		if die.value == -1:
			total = 0
			return
		if die.value == number:
			total += (number + 1) * multiplier


func _on_button_pressed():
	var game = get_tree().get_first_node_in_group("KeyScene")
	accepted = true
	%Button.disabled = true
	
	game.calculate_score()
	
	if get_tree().get_first_node_in_group("Game").continue_game():
		game.end_joker()
		game.reset_rolls()
	else:
		get_tree().get_first_node_in_group("Game").game_over()
