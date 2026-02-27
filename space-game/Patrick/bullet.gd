extends Area2D

@export var speed: float = 600.0

func _process(delta):
	# Move up (negative Y)
	position.y -= speed * delta
	
	# Delete when off screen
	if position.y < -50:
		queue_free()
