extends KinematicBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var velocity = Vector2.ZERO

onready var sprite = $AnimatedSprite

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var yDirection = Input.get_axis("move_up","move_down")
	var direction = Input.get_axis("move_left", "move_right")
	if direction or yDirection:
		velocity.x = direction * SPEED
		velocity.y = yDirection * SPEED
		sprite.animation = "Run"
		if direction > 0:
			sprite.flip_h = false
		elif direction < 0:
			sprite.flip_h = true
	else:
		sprite.animation = "Idle"
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		

	move_and_slide(velocity, Vector2.UP)

#const UP_DIRECTION := Vector2.UP
#
#export var speed := 600.0
#
#export var jump_strength := 1500.0
#export var maximum_jumps := 2
#export var double_jump_strength :=1200.0
#export var gravity := 4500.0
#
#
#var _jumps_made := 0
#var _velocity := Vector2.ZERO
#
#func _phsics_process(delta: float)  -> void:
#	var _horizontal_direction = (
#		Input.get_action_strength("move_right")
#		- Input.get_action_strength("move_left")
#	)
#
#	_velocity.x = _horizontal_direction * speed
#	_velocity.y += gravity * delta
#
#	var is_falling := _velocity.y > 0.0 and not is_on_floor()
#	var is_jumping := Input.is_action_just_pressed("jump") and is_on_floor()
#	var is_double_jumping := Input.is_action_just_pressed("jump") and is_falling
#	var is_jump_cancelled := Input.is_action_just_released("jump") and _velocity.y < 0.0
#	var is_idling := is_on_floor() and is_zero_approx(_velocity.x)
#	var is_running := is_on_floor() and not is_zero_approx(_velocity.x)
#
#	if is_jumping:
#		_jumps_made += 1
#		_velocity.y = -jump_strength
#	elif is_double_jumping:
#		_jumps_made += 1
#	if _jumps_made <= maximum_jumps:
#		 _velocity.y = -double_jump_strength
#
#	_velocity = move_and_slide(_velocity, UP_DIRECTION)
