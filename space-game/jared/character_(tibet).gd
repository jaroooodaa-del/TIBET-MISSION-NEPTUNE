extends CharacterBody2D

## Movement Tuning
const SPEED = 300.0
const JUMP_VELOCITY = -450.0 # Slightly higher to help with those snowy peaks
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

	# 2. Jump Input (Space, W, or Up Arrow)
	if Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		jump_buffer_timer = JUMP_BUFFER
	else:
		jump_buffer_timer -= delta

	# 3. Execution of Jump
	if jump_buffer_timer > 0 and coyote_timer > 0:
		velocity.y = JUMP_VELOCITY
		jump_buffer_timer = 0 
		coyote_timer = 0

	# 4. Horizontal Movement (A/D and Left/Right Arrows)
	var direction = 0
	
	# Check Right (D or Right Arrow)
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		direction += 1
	# Check Left (A or Left Arrow)
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		direction -= 1
	
	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
		
		# Flip the sprite if you have one attached named "Sprite2D"
		if has_node("Sprite2D"):
			$Sprite2D.flip_h = (direction < 0)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

	move_and_slide()
