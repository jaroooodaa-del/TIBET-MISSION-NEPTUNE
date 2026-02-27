extends Area2D

@export var speed: float = 200.0

func _process(delta):
	# This line makes it fall down into view!
	position.y += speed * delta
	
	# Deletes it if it goes past the bottom so your game stays fast
	if position.y > 1100:
		queue_free()

func _on_body_entered(body):
	# Checks if the player touched it
	if body.has_method("upgrade_fire_rate"):
		body.upgrade_fire_rate()
		queue_free() # Remove from screen after collection
