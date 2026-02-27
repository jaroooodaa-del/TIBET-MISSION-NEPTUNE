extends Area2D

@export var speed: float = 700.0

func _physics_process(delta):
	# Move the bullet forward based on its own rotation
	# Vector2.RIGHT is the "forward" direction in Godot 2D
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	# Delete the bullet when it leaves the screen to save memory
	queue_free()
