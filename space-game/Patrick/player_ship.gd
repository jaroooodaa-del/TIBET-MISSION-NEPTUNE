extends CharacterBody2D

@export var speed: float = 400.0
@export var bullet_scene: PackedScene 

func _physics_process(_delta):
	# 1. FOLLOW MOUSE MOVEMENT
	var mouse_pos = get_global_mouse_position()
	
	# Calculate direction toward mouse
	var direction = (mouse_pos - global_position).normalized()
	
	# Only move if the mouse is further than 5 pixels away (prevents "jittering")
	if global_position.distance_to(mouse_pos) > 5:
		velocity = direction * speed
		move_and_slide()
	
	# OPTIONAL: Make the ship rotate to face the mouse
	# look_at(mouse_pos)
	# rotation_degrees += 90 # Adjust this if your sprite faces the wrong way

	# 2. HOLD SPACE TO SHOOT
	if Input.is_action_pressed("ui_accept"):
		if $ShootTimer.is_stopped():
			shoot()            
			$ShootTimer.start() 
	else:
		$ShootTimer.stop()     

func shoot():
	if bullet_scene:
		# Shooting from multiple muzzles at once
		if has_node("Muzzles"):
			for muzzle in $Muzzles.get_children():
				var bullet = bullet_scene.instantiate()
				bullet.global_position = muzzle.global_position
				get_tree().current_scene.add_child(bullet)
		else:
			# Fallback if Muzzles node is missing
			var bullet = bullet_scene.instantiate()
			bullet.global_position = global_position
			get_tree().current_scene.add_child(bullet)

func die():
	print("Player Destroyed!")
	get_tree().reload_current_scene()

# POWER-UP SYSTEM
func faster_fire_rate():
	print("Power-up received! Rapid fire active.")
	if has_node("ShootTimer"):
		var timer = $ShootTimer
		var original_speed = timer.wait_time
		
		timer.wait_time = 0.1 # High-speed fire
		
		# Power-up lasts for 5 seconds
		await get_tree().create_timer(5.0).timeout
		
		timer.wait_time = original_speed
		print("Power-up expired.")
