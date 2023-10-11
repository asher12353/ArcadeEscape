extends CharacterBody3D

@export var tv: StaticBody3D

var main_character: CharacterBody3D
var world: Node3D
var camera: Camera3D

func _ready():
	main_character = tv.main_character
	world = tv.world
	camera = tv.camera

func _input(event):
	if main_character == self:
		if Input.is_action_just_pressed("ui_cancel"):
			world.current_character = main_character
			camera.make_current()
