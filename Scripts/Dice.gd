extends Sprite2D

class_name Dice

var result: int
var held = false
var value = 0 

var textures: Array[Texture] = [load("res://Assets/Dice-1.png"), load("res://Assets/Dice-2.png"), load("res://Assets/Dice-3.png"), \
load("res://Assets/Dice-4.png"), load("res://Assets/Dice-5.png"), load("res://Assets/Dice-6.png")]

func roll():
	value = randi_range(0, 5)
	texture = textures[value]

func _on_button_toggled(toggled_on):
	held = toggled_on

func unhold():
	held = false
	%Button.button_pressed = false
