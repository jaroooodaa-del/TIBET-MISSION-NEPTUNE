extends CharacterBody2D

## Movement Tuning
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const FRICTION = 1200.0  
const ACCELERATION = 1000.0

## Feel Enhancements
const COYOTE_TIME = 0.15 
const JUMP_BUFFER = 0.1  

var coyote_timer = 0.0
var jump_buffer_timer = 0.0

func _physics_process(delta: float) -> void:
	# 1. Gravity Logic
	if not is_on_floor():
		velocity += get_gravity() * delta
		coyote_timer -= delta
	else:
		coyote_timer = COYOTE_TIME 

	# 2. Jump Input (Space Bar)
	if Input.is_key_pressed(KEY_SPACE):
		jump_buffer_timer = JUMP_BUFFER
	else:
		jump_buffer_timer -= delta

	# 3. Execution of Jump
	if jump_buffer_timer > 0 and coyote_timer > 0:
		velocity.y = JUMP_VELOCITY
		jump_buffer_timer = 0 
		coyote_timer = 0

	# 4. Horizontal Movement (A and D)
	var direction = 0
	if Input.is_key_pressed(KEY_D):
		direction += 1
	if Input.is_key_pressed(KEY_A):
		direction -= 1
	
	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
		# Optional: Flip the character sprite based on direction
		if direction > 0:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
