extends Node2D

@export var powerup_scene: PackedScene

func _on_timer_timeout():
	if powerup_scene == null:
		print("Error: No powerup scene assigned to the spawner!")
		return
		
	# 1. Instantiate the powerup
	var powerup = powerup_scene.instantiate()
	
	# 2. Pick a random X position at the top of the screen
	var screen_width = get_viewport_rect().size.x
	var random_x = randf_range(50, screen_width - 50)
	
	# 3. Position it just above the top edge
	powerup.position = Vector2(random_x, -50)
	
	# 4. Add it to the main game scene
	get_parent().add_child(powerup)
	
	print("Power-up spawned!")
