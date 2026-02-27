extends Area2D

@export var speed: float = 600.0

func _process(delta):
	# Move up (negative Y direction in Godot 2D)
	position.y -= speed * delta
	
	# Automatically remove the bullet once it goes off the top of the screen
	if position.y < -50:
		queue_free()

# This handles hitting an enemy (if you have an enemy group set up)
func _on_body_entered(body):
	if body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			body.take_damage()
		queue_free() # Destroy bullet on impact
