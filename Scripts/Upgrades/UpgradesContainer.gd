extends HBoxContainer

class_name UpgradesContainer

func reset(removed_upgrade):
	removed_upgrade.queue_free()
	await get_tree().process_frame
	for child in get_children():
		remove_child(child)
		get_parent().get_parent().reaccept_node(child)
