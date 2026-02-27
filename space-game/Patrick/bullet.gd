extends Area2D

@export var speed: float = 600.0

func _process(delta):
	# Move the bullet
	position.y -= speed * delta
	
	# DEBUG: Print the position to see where it's going
	# print("Bullet Y: ", position.y)

	# FIX: Make sure this number isn't killing the bullet too early
	# If your screen is 1080 high, and the bullet starts at 500, 
	# setting this to > 0 will kill it instantly!
	if position.y < -500: 
		queue_free()
