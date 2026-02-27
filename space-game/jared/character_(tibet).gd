extends CharacterBody2D

@export var speed := 200.0
@export var jump_force := -350.0   # 👈 lower jump
@export var gravity := 900.0

@onready var sprite := $AnimatedSprite2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed

	if direction < 0:
		sprite.flip_h = true
	elif direction > 0:
		sprite.flip_h = false

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force

	move_and_slide()
