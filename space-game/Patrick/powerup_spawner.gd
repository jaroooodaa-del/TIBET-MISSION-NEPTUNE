extends Node2D  # Changed back from Area2D to match the node type

@export var powerup_scene: PackedScene

func _on_timer_timeout():
	if powerup_scene == null:
		return
		
	# 1. Create the instance
	var powerup = powerup_scene.instantiate()
	
	# 2. Pick a random X position
	var screen_width = get_viewport_rect().size.x
	var random_x = randf_range(50, screen_width - 50)
	
	# 3. Position it at the top
	powerup.position = Vector2(random_x, -50)
	
	# 4. Add it to the main game
	get_parent().add_child(powerup)
	print("SUCCESS: Power-up spawned!")
