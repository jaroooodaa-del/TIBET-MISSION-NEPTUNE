extends CharacterBody2D

@export var speed: float = 400.0
@export var bullet_scene: PackedScene 

# Power-up variables
var fire_rate: float = 0.5  # Seconds between shots
var min_fire_rate: float = 0.1 

@onready var shoot_timer = $ShootTimer

func _ready():
	shoot_timer.wait_time = fire_rate

func _physics_process(_delta):
	# 1. MOUSE MOVEMENT
	var mouse_pos = get_global_mouse_position()
	global_position = global_position.move_toward(mouse_pos, speed * _delta)
	
	# 2. AUTOMATIC SHOOTING
	# This runs every frame. If the timer is stopped, it fires and restarts the timer.
	if shoot_timer.is_stopped():
		shoot()
		shoot_timer.start()

func shoot():
	if bullet_scene == null: return
	
	if has_node("Muzzles"):
		for muzzle in $Muzzles.get_children():
			var b = bullet_scene.instantiate()
			get_parent().add_child(b)
			b.global_transform = muzzle.global_transform

# This is called by your PowerUp scene
func upgrade_fire_rate():
	# Reduces delay by 0.1, but never goes below 0.1 total
	fire_rate = max(min_fire_rate, fire_rate - 0.1)
	shoot_timer.wait_time = fire_rate
	print("Automatic fire speed increased! Current delay: ", fire_rate)
