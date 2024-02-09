extends Camera3D

func _process(_delta):
	position.x = get_parent().get_parent().position.x
	position.y = get_parent().get_parent().position.y + 5
	position.z = get_parent().get_parent().position.z + 1
	$Label3D.text = str($"../..".value + 1) if $"../..".value != -1 else ""
