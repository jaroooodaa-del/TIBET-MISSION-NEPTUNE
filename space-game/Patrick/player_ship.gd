extends CharacterBody2D

# --- Variables ---
@export var speed: float = 400.0
@export var max_health: int = 3
@export var bullet_scene: PackedScene 

var fire_rate: float = 0.5  
var min_fire_rate: float = 0.1 
var current_health: int 

@onready var shoot_timer = $ShootTimer

# --- Core Functions ---

func _ready():
	# Initialize health and timer
	current_health = max_health
	shoot_timer.wait_time = fire_rate

func _physics_process(delta):
	# Movement: Follow the mouse position
	var mouse_pos = get_global_mouse_position()
	global_position = global_position.move_toward(mouse_pos, speed * delta)
	
	# Automatic Shooting: Fires whenever the timer finishes
	if shoot_timer.is_stopped():
		shoot()
		shoot_timer.start()

func shoot():
	if bullet_scene == null: 
		return
	
	# Looks for the Node2D container we named "Muzzles"
	if has_node("Muzzles"):
		for muzzle in $Muzzles.get_children():
			if muzzle is Marker2D:
				var b = bullet_scene.instantiate()
				get_parent().add_child(b)
				b.global_transform = muzzle.global_transform
	else:
		print("Error: No node named 'Muzzles' found!")

# --- Power-Up and Health Functions ---

func upgrade_fire_rate():
	# Reduces time between shots by 0.1s
	fire_rate = max(min_fire_rate, fire_rate - 0.1)
	shoot_timer.wait_time = fire_rate
	print("Power-up collected! New fire rate: ", fire_rate)

func take_damage(amount: int):
	current_health -= amount
	print("Health remaining: ", current_health)
	if current_health <= 0:
		die()

func die():
	print("Player Destroyed!")
	# Restarts the current level
	get_tree().reload_current_scene()
