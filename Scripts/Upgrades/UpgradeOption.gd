extends VBoxContainer

class_name UpgradeOption

func _on_button_pressed():
	get_parent().get_parent().visible = false
	get_parent().reset()
	get_parent().get_parent().get_parent().upgrades.erase(self)
	queue_free()
	
