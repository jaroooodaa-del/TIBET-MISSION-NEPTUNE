extends Node2D

# --- Configuration ---
@export var enemy_scene: PackedScene # Drag your EnemyShip.tscn here in the Inspector
@export var initial_spawn_rate: float = 1.5
@export var difficulty_step: float = 0.2
@export var minimum_spawn_rate: float = 0.3

# --- Node References ---
@onready var spawn_timer = $Timer 
@onready var difficulty_timer = $DifficultyTimer

# Get screen width from project settings for random positioning
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

func _ready():
	# Initialize timers
	spawn_timer.wait_time = initial_spawn_rate
	spawn_timer.start()
	
	difficulty_timer.wait_time = 30.0
	difficulty_timer.start()
	
	print("Spawner Active. Starting spawn rate: ", initial_spawn_rate)

# --- Spawning Logic ---
# Connected to Timer.timeout()
func _on_timer_timeout():
	if enemy_scene:
		# Create the enemy
		var enemy = enemy_scene.instantiate()
		
		# Pick a random horizontal position
		var random_x = randf_range(50, screen_width - 50)
		
		# Set position just above the screen
		enemy.global_position = Vector2(random_x, -100)
		
		# Add to the level
		get_tree().current_scene.add_child(enemy)
	else:
		print("Warning: No Enemy Scene assigned to the Spawner!")

# --- Difficulty Scaling ---
# Connected to DifficultyTimer.timeout()
func _on_difficulty_timer_timeout():
	# Reduce the wait time
	var new_rate = spawn_timer.wait_time - difficulty_step
	
	# Clamp the rate so it doesn't become 0 or negative
	spawn_timer.wait_time = max(minimum_spawn_rate, new_rate)
	
	print("Difficulty Increased! New spawn rate: ", spawn_timer.wait_time)
