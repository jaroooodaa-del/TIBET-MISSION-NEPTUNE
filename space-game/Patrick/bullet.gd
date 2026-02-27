extends Area2D

@export var speed: float = 600.0
@export var damage: int = 1

func _physics_process(delta):
	# Move the bullet upward every frame
	position += Vector2.UP * speed * delta

func _on_body_entered(body: Node2D) -> void:
	# Check if the thing we hit is in the "enemies" group
	if body.is_in_group("enemies"):
		# If the enemy has a 'take_damage' function, use it
		if body.has_method("take_damage"):
			body.take_damage(damage)
		else:
			# If no health system yet, just delete the enemy
			body.queue_free()
		
		# Delete the bullet after it hits something
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# Delete the bullet when it flies off the top to save memory
	queue_free()
