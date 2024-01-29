extends HBoxContainer

class_name PatternTrick

var accepted = false
var total = 0
@export var string_name = "Pattern"

func _ready():
	%Label.text = string_name

func _process(_delta):
	%TrickTotal.text = str(total)

func calculate():
	total = trick_calculation()

func trick_calculation() -> int:
	return 0

func _on_button_pressed():
	accepted = true
	%Button.disabled = true
	get_tree().get_first_node_in_group("Game").reset_rolls()
