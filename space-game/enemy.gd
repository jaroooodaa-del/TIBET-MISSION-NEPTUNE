extends Area2D

@export var speed: float = 200.0
@export var health: int = 1

func _process(delta):
	# Move the enemy down the screen
	position.y += speed * delta
	
	# Delete if it flies off the bottom
	if position.y > 1000: 
		queue_free()

func take_damage(amount):
	health -= amount
	if health <= 0:
		# Add explosion logic here later!
		queue_free()
