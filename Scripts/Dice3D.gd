extends RigidBody3D

class_name Dice3D

var held = false
var value = -1
var active_sides = []

func _ready():
	roll()

func roll():
	if held: return
	position = Vector3(0, 10, 0)
	angular_velocity = Vector3(randi_range(5, 10), randi_range(5, 10), randi_range(5, 10))
	value = -1

func _physics_process(_delta):
	var threshold = 0.01
	if angular_velocity.length() < threshold:
		angular_velocity = Vector3.ZERO
	if linear_velocity.length() < threshold:
		linear_velocity = Vector3.ZERO

	if value == -1 and angular_velocity == Vector3.ZERO and linear_velocity == Vector3.ZERO:
		if active_sides.size() == 1:
			value = int(String(active_sides[0].name))
