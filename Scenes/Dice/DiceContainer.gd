extends SubViewportContainer
#
func _on_area_3d_body_entered(body):
	%Dice.active_sides.append(body)


func _on_area_3d_body_exited(body):
	%Dice.active_sides.erase(body)\
