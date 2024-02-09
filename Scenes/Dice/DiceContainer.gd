extends SubViewportContainer


func _on_area_3d_area_entered(area):
	%Dice.active_sides.append(area)


func _on_area_3d_area_exited(area):
	%Dice.active_sides.erase(area)
