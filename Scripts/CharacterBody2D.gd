extends CharacterBody2D

@export var tv: StaticBody3D
@export var animator: AnimatedSprite2D

var main_character: CharacterBody3D
var world: Node3D
var camera: Camera3D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	main_character = tv.main_character
	world = tv.world
	camera = tv.camera

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		animator.pause()
		animator.play("jump")
		velocity.y += gravity * delta
	
	if world.current_game == self:
		if Input.is_action_just_pressed("ui_cancel"):
			world.current_character = main_character
			world.current_game = null
			camera.make_current()
		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("move_left", "move_right")
		if direction:
			animator.pause()
			animator.play("walk")
			velocity.x = direction * SPEED
		else:
			animator.pause()
			animator.play("idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
