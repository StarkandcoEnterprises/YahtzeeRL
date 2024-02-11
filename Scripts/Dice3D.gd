extends RigidBody3D

class_name Dice3D

var held = false
var value = -1
var active_sides = []
var possible_values = [0, 1, 2, 3, 4, 5]
var tween


func _ready():
	roll()

func roll():
	if held: return
	while global_position.y <= 9:
		await get_tree().physics_frame
		global_position = Vector3(0, 10, 0)
	var x_rotate = randi_range(15, 30) if randi() % 2 == 0 else randi_range(-30, -15)
	var y_rotate = randi_range(15, 30) if randi() % 2 == 0 else randi_range(-30, -15)
	var z_rotate = randi_range(15, 30) if randi() % 2 == 0 else randi_range(-30, -15)
	linear_velocity = Vector3(x_rotate, y_rotate, z_rotate)
	angular_velocity = Vector3(x_rotate, y_rotate, z_rotate)
	value = -1

func _physics_process(_delta):
	if value != -1:
		if tween:
			tween.kill()
		tween = null
	if value == -1 and abs(angular_velocity.round()) == Vector3.ZERO and abs(linear_velocity.round()) == Vector3.ZERO:
		var _debug = fmod(abs(rotation.x), 90)
		var _debug2 = fmod(abs(rotation.z), 90)
		if fmod(abs(rotation.x), 90) <= 5 and fmod(abs(rotation.z), 90) <= 5:
			if active_sides.size() == 1:
				value = possible_values[int(String(active_sides[0].name))]
			else:
				if !tween and(fmod(abs(rotation.x), 90) < 5 and fmod(abs(rotation.z), 90) < 5):
					tween = create_tween()
					tween.tween_property(self, "angular_velocity", Vector3(5,0,5), 1).set_delay(5)
					tween.finished.connect(tween_free)
		else:
			if !tween and(fmod(abs(rotation.x), 90) > 5 and fmod(abs(rotation.z), 90) > 5):
				tween = create_tween()
				tween.tween_property(self, "angular_velocity", Vector3(5,0,5), 1).set_delay(5)
				tween.finished.connect(tween_free)

func tween_free():
	tween.kill()
	tween = null


