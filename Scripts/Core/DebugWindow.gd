extends Window

@onready var game = get_tree().get_first_node_in_group("Game")

func _on_yahtzee_pressed():
	var ref_die = get_tree().get_first_node_in_group("Dice")
	var new_val = ref_die.possible_values[randi_range(0, 5)]
	
	for die: Dice in get_tree().get_nodes_in_group("Dice"):
		die.value = new_val
		die.texture = die.textures[new_val]
	game.get_node("KeyGameScene").calculate_totals()


func _on_full_house_pressed():
	var ref_die = get_tree().get_first_node_in_group("Dice")
	
	var new_val = ref_die.possible_values[randi_range(0, 5)]
	var second_new_val = ref_die.possible_values[randi_range(0, 5)]
	
	while(new_val == second_new_val):
		second_new_val = ref_die.possible_values[randi_range(0, 5)]
	
	var count = 0
	
	for die: Dice in get_tree().get_nodes_in_group("Dice"):
		if count < 3:
			die.value = new_val
			die.texture = die.textures[new_val]
			count += 1
		else:
			die.value = second_new_val
			die.texture = die.textures[second_new_val]
	
	game.get_node("KeyGameScene").calculate_totals()
	
func _on_upgrade_menu_pressed():
	game.get_node("%UpgradePanel").visible = true
	
	var number_of_upgrades = 3
	
	if !game.upgrades:
		game.upgrades = game.all_upgrades.duplicate()
	
	if game.upgrades.size() < 3: number_of_upgrades = game.upgrades.size()
	
	if number_of_upgrades == 0: return
	
	for x in number_of_upgrades:
		var upgrade = game.upgrades.pop_at(randi_range(0, game.upgrades.size() - 1))
		game.get_node("%UpgradePanel").get_child(0).add_child(game.upgrades.pop_at(randi_range(0, game.upgrades.size() - 1)))
		if is_instance_valid(upgrade):
			game.get_node("%UpgradePanel").get_child(0).add_child(upgrade)
