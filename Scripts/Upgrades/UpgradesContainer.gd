extends HBoxContainer

class_name UpgradesContainer

func reset():
	for child in get_children():
		get_parent().get_parent().upgrades.append(child)
