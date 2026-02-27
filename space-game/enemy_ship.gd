extends CharacterBody2D

@export var speed: float = 200.0
@export var health: int = 2
@export var damage_value: int = 1

func _ready():
	# Add to group so the Bullet can find it easily
	add_to_group("enemies")

func _physics_process(_delta):
	# Move straight down
	velocity = Vector2.DOWN * speed
	move_and_slide()
	
	# Delete if it flies past the player (off-bottom)
	if global_position.y > 1100:
		queue_free()

# Matches the Bullet script's call
func take_damage(amount: int = 1):
	health -= amount
	if health <= 0:
		die()

func die():
	print("Enemy destroyed!")
	queue_free()

# Connect this from an Area2D child node named "Hitbox"
func _on_hitbox_body_entered(body):
	if body.has_method("die"):
		body.die()
		die()
		
		
