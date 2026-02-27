extends CharacterBody2D

@export var speed := 250
@export var jump_force := -420
@export var gravity := 900

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Horizontal movement
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force

	move_and_slide()

	_update_animation(direction)

func _update_animation(direction):
	if not is_on_floor():
		sprite.play("jump")
	elif direction != 0:
		sprite.play("run")
		sprite.flip_h = direction < 0
	else:
		sprite.play("idle")x
