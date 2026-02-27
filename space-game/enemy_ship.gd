extends CharacterBody2D

# --- Variables ---
@export var speed: float = 200.0
@export var health: int = 2
@export var damage_value: int = 1

func _physics_process(delta):
	# Basic enemy movement: Fly downwards toward the player
	# You can change Vector2.DOWN to move in different directions
	velocity = Vector2.DOWN * speed
	move_and_slide()

# This function is called by the Bullet when it hits this enemy
func take_damage(amount: int):
	health -= amount
	print("Enemy hit! Health remaining: ", health)
	
	# Add a brief visual flash here later!
	
	if health <= 0:
		die()

func die():
	# Replace this with an explosion effect later
	print("Enemy destroyed!")
	queue_free()

# --- Optional: Damage the player on contact ---
# If your enemy has an Area2D "Hitbox" child, connect its body_entered signal here
func _on_hitbox_body_entered(body):
	if body.name == "PlayerShip" or body.has_method("take_damage"):
		body.take_damage(damage_value)
		die() # Enemy explodes on impact
