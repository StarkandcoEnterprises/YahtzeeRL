extends HBoxContainer

class_name Trick

@onready var game = get_tree().get_first_node_in_group("Game")

@export var number = 0
@export var string_name = "Ones"

var accepted = false
var total = 0

func _ready():
	%Label.text = string_name

func _process(_delta):
	%TrickTotal.text = str(total)
	%Label.text = string_name

func calculate():
	total = 0
	for die in get_tree().get_nodes_in_group("Dice"):
		if die.value == number:
			total += number + 1


func _on_button_pressed():
	accepted = true
	%Button.disabled = true
	if game.continue_game():
		game.get_node("KeyGameScene").reset_rolls()
	else:
		game.game_over()
