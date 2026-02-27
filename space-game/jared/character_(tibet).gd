extends CharacterBody2D

## Movement Tuning (Now Slower & Lower)
const SPEED = 200.0          # Reduced from 300
const JUMP_VELOCITY = -300.0  # Reduced from 450
const FRICTION = 1000.0  
const ACCELERATION = 800.0

## Feel Enhancements
const COYOTE_TIME = 0.15 
const JUMP_BUFFER = 0.1  

var coyote_timer = 0.0
var jump_buffer_timer = 0.0

@onready var sprite = $AnimatedSprite2D # Assumes your node is named AnimatedSprite2D

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

	# 4. Horizontal Movement (A/D and Arrows)
	var direction = 0
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		direction += 1
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		direction -= 1
	
	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
		
		# 5. Handle Animations
		if direction > 0:
			sprite.play("move_right_anim")
		else:
			sprite.play("move_left_anim")
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		# Optional: Stop animation or play "idle" when not moving
		sprite.stop() 

	move_and_slide()
	
	
	
func faster_fire_rate():
	print("Power-up received! Rapid fire active.")
	if has_node("ShootTimer"):
		var timer = get_node("ShootTimer")
		
		# 1. Save the old speed so we can go back to it
		var original_speed = timer.wait_time 
		
		# 2. Set the new fast speed
		timer.wait_time = 0.1
		timer.start()
		
		# 3. Wait for 5 seconds in the background
		await get_tree().create_timer(5.0).timeout
		
		# 4. Set it back to normal
		timer.wait_time = original_speed
		print("Power-up expired. Back to normal.")
