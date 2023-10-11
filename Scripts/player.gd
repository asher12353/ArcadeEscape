extends CharacterBody3D

@onready var head = $head
@onready var camera_3d = $head/Camera3D
@onready var world = $".."

var current_camera

# movement constants
const speed = 7.5
const mouse_sensitivity = 0.3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	current_camera = get_viewport().get_camera_3d()

func _input(event):
	if world.current_character == self:
		if event is InputEventMouseMotion && current_camera == camera_3d:
			rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
			head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
			

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if world.current_character == self:
		# i'll probably want this to be implemented into a pause button later
		#if Input.is_action_pressed("ui_cancel"):
		#	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

		var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
