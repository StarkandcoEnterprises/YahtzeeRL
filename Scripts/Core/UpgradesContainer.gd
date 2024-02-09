extends HBoxContainer

class_name UpgradesContainer

func reset(removed_upgrade):
	removed_upgrade.queue_free()
	while is_instance_valid(removed_upgrade):
		await get_tree().process_frame
	for child in get_children():
		remove_child(child)
		get_tree().get_first_node_in_group("Game").reaccept_node(child)
