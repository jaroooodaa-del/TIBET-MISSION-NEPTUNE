extends CharacterBody2D

## Movement Tuning
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const FRICTION = 1200.0  # Higher value = quicker stops
const ACCELERATION = 1000.0

## Feel Enhancements
const COYOTE_TIME = 0.15 # Seconds you can still jump after walking off a ledge
const JUMP_BUFFER = 0.1  # Seconds to remember a jump press before hitting the ground

var coyote_timer = 0.0
var jump_buffer_timer = 0.0

func _physics_process(delta: float) -> void:
	# 1. Gravity Logic
	if not is_on_floor():
		velocity += get_gravity() * delta
		coyote_timer -= delta
	else:
		coyote_timer = COYOTE_TIME # Reset timer while on ground

	# 2. Jump Buffering (Remembers your "Jump" tap right before landing)
	if Input.is_action_just_pressed("ui_accept"):
		jump_buffer_timer = JUMP_BUFFER
	else:
		jump_buffer_timer -= delta

	# 3. Execution of Jump
	if jump_buffer_timer > 0 and coyote_timer > 0:
		velocity.y = JUMP_VELOCITY
		jump_buffer_timer = 0 # Reset so we don't double jump
		coyote_timer = 0

	# 4. Variable Jump Height (Release button early for a shorter hop)
	if Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y *= 0.5 # Cut upward momentum in half

	# 5. Horizontal Movement (Smooth Acceleration/Friction)
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

	move_and_slide()
