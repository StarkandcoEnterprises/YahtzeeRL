extends UpgradeOption

class_name ChangeTwoToEight

@onready var model_a = preload("res://Assets/3D Models/Dice3DWith8.glb")
@onready var model_b = preload("res://Assets/3D Models/Dice3DWith7and8.glb")
@onready var model_c = preload("res://Assets/3D Models/Dice3DWith8and9.glb")
@onready var model_d = preload("res://Assets/3D Models/Dice3DWith7and8and9.glb")

func _on_button_pressed():
	change_trick()
	await change_dice()
	get_tree().get_first_node_in_group("KeyScene").reset_rolls()
	super()

func change_trick():
	for trick in get_tree().get_nodes_in_group("Trick"):
		if trick.string_name == "Twos":
			trick.number = 7
			trick.string_name = "Eights"
			return

func change_dice():
	for die in get_tree().get_nodes_in_group("Dice"):
		if die.possible_values.find(1) != -1:
			die.possible_values.insert(die.possible_values.find(1), 7)
			die.possible_values.remove_at(die.possible_values.find(1))
			die.get_node("DiceModel").queue_free()
			while is_instance_valid(die.get_node("DiceModel")):
				await get_tree().process_frame
			change_3d_model(die)
	return 0

func change_3d_model(die):
	if die.possible_values.find(6) != -1:
		if die.possible_values.find(8) != -1:
			var new_model = model_d.instantiate()
			die.add_child(new_model)
			new_model.name = "DiceModel"
		else:
			var new_model = model_b.instantiate()
			die.add_child(new_model)
			new_model.name = "DiceModel"
	elif die.possible_values.find(8) != -1:
		var new_model = model_c.instantiate()
		die.add_child(new_model)
		new_model.name = "DiceModel"
	else:
		var new_model = model_a.instantiate()
		die.add_child(new_model)
		new_model.name = "DiceModel"
