extends CharacterBody2D

@export var speed: float = 400.0
@export var bullet_scene: PackedScene # Drag your bullet.tscn here in the Inspector

func _physics_process(_delta):
	# 1. Movement Logic
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()

	# 2. Shooting Logic (Hold Space to Shoot)
	if Input.is_action_pressed("ui_accept"):
		if $ShootTimer.is_stopped():
			shoot()            # Fire the first bullet immediately
			$ShootTimer.start() # Start the interval for holding down the key
	else:
		$ShootTimer.stop()     # Stop firing when key is released

func shoot():
	if bullet_scene:
		var bullet = bullet_scene.instantiate()
		# Set bullet starting position to the ship's position
		bullet.global_position = global_position 
		# Add bullet to the main game scene so it moves independently of the ship
		get_tree().current_scene.add_child(bullet)

func die():
	print("Player Destroyed!")
	get_tree().reload_current_scene()

# This is called by the Power-up Area2D
func faster_fire_rate():
	print("Power-up received! Shooting faster now.")
	
	if has_node("ShootTimer"):
		var timer = $ShootTimer
		var original_speed = timer.wait_time
		
		timer.wait_time = 0.1 # Rapid fire speed
		
		# Optional: This makes the power-up last for 5 seconds
		await get_tree().create_timer(5.0).timeout
		
		timer.wait_time = original_speed
		print("Power-up expired.")
