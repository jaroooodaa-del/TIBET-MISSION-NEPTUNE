extends Area2D

@export var speed: float = 250.0

func _process(delta):
	position.y += speed * delta
	if position.y > 1100:
		queue_free()

# This function is triggered by the Signal
func _on_body_entered(body):
	# Check if the thing we hit is the Player
	if body.has_method("faster_fire_rate"):
		body.faster_fire_rate() # Call the function on the player
		print("COLLECTED: Power-up disappeared!")
		queue_free() # Remove the power-up from the game
