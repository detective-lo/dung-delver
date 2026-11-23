extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		# Fall animation?

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		velocity.x = direction * SPEED
		anim.play("walk")
		anim.flip_h = false
	elif direction < 0:
		velocity.x = direction * SPEED
		anim.play("walk")
		anim.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim.play("idle")
		
	move_and_slide()
