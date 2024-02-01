extends RigidBody3D

class_name Dice3D

var held = false
var value = -1
var possible_values = [0, 1, 2, 3, 4, 5]
var active_side

func _ready():
	roll()

func roll():
	if held: return
	value = -1
	position = Vector3(0, 10, 0)
	angular_velocity = Vector3(randi_range(5, 10), randi_range(5, 10), randi_range(5, 10))
	get_tree().create_timer(5).timeout.connect(end_velocity)

func _physics_process(delta):
	if angular_velocity == Vector3.ZERO:
		if active_side:
			value = active_side

func end_velocity():
	angular_velocity = Vector3.ZERO
	while get_parent().get_node("%Area3D").get_overlapping_bodies().size() == 0:
		await get_tree().physics_frame
	var debug = get_parent().get_node("%Area3D").get_overlapping_bodies()
	active_side = int(get_parent().get_node("%Area3D").get_overlapping_bodies()[0].name)
