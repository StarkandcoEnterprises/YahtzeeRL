extends Node2D

@export var key_scene: PackedScene

var games_complete = 1
var score_minimum = 150

var all_upgrades: Array[UpgradeOption] = create_array()
#var all_upgrades: Array[UpgradeOption] = [preload("res://Scenes/Upgrades/Change1to7.tscn").instantiate(), preload("res://Scenes/Upgrades/Change2to8.tscn").instantiate(), preload("res://Scenes/Upgrades/Change3to9.tscn").instantiate(), preload("res://Scenes/Upgrades/SecondFiveRand.tscn").instantiate()]
var upgrades: Array[UpgradeOption] = []

func _ready():
	$KeySceneContainer.add_child(key_scene.instantiate())

func continue_game():
	for trick in get_tree().get_nodes_in_group("Trick"):
		if !trick.accepted: return true
	return false

func game_over():
	var current_scene = get_tree().get_first_node_in_group("KeyScene")
	current_scene.current_rolls = 0
	toggle_dice_roll_buttons()
	current_scene.toggle_roll()
	
	var score = calculate_final_score()
	
	if score <= current_scene.minimum:
		%FinalScore.text = "Final Score: " + str(score)
		%EndGamePanel.visible = true
		games_complete = 1
		upgrades = all_upgrades.duplicate()
	else:
		current_scene.score = 0
		current_scene.minimum += 50 * games_complete
		var number_of_upgrades = 3
		
		if !upgrades:
			upgrades = all_upgrades.duplicate()
		
		if upgrades.size() < 3: number_of_upgrades = upgrades.size()
		
		if number_of_upgrades == 0: 
			games_complete += 1
			reset_tricks()
			toggle_dice_roll_buttons()
			current_scene.toggle_roll()
			return
		
		upgrades.shuffle()
		
		for x in number_of_upgrades:
			if upgrades.size() == 0: break
			var upgrade = upgrades.pop_front()
			if is_instance_valid(upgrade):
				%UpgradePanel.get_child(0).add_child(upgrade)
		if %UpgradePanel.get_child(0).get_child_count() > 0:
			%UpgradePanel.visible = true
		games_complete += 1
		reset_tricks()
		toggle_dice_roll_buttons()
		current_scene.toggle_roll()

func calculate_final_score() -> int:
	var final_score = 0
	for trick in get_tree().get_nodes_in_group("Trick"):
		final_score += trick.total
	return final_score

func reset_tricks():
	for trick in get_tree().get_nodes_in_group("Trick"):
		trick.accepted = false
		trick.get_node("%Button").disabled = false
		if trick is Yahtzee:
			trick.state = trick.UNSCORED
			trick.total = 0
			trick.yahtzees_scored = 0

func _on_new_game_pressed():
	%EndGamePanel.visible = false
	get_tree().get_first_node_in_group("KeyScene").queue_free()
	await get_tree().process_frame
	await get_tree().process_frame
	$KeySceneContainer.add_child(key_scene.instantiate())

func toggle_dice_roll_buttons():
	for die: Dice in get_tree().get_nodes_in_group("Dice"):
		die.get_node("%Button").disabled = !die.get_node("%Button").disabled

func create_array() -> Array[UpgradeOption]:
	var path = "res://Scenes/Upgrades/"
	var dir = DirAccess.open(path)
	var temp_dir: Array[UpgradeOption] = []
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with("."):
			#get_next() returns a string so this can be used to load the images into an array.
			temp_dir.append(load(path + file_name).instantiate())
	dir.list_dir_end()
	return temp_dir

func reaccept_node(child):
	upgrades.append(child)
