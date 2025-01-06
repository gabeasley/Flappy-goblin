extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	velocity.x = SPEED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("flap"):
		velocity.y = JUMP_VELOCITY

	velocity.x = move_toward(velocity.x, SPEED, SPEED)

	move_and_slide()
