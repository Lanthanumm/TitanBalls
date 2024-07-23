extends CharacterBody2D

@export var speed = 300.0
@export var decceleration = 60.0
@export var acceleration = 60.0

@export var jump_velocity = -1000.0
@export var gravity = 2750.0

@export var huge_jump_speed = 300.0

@onready var sprite = $Sprite

var direction: float


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	
	handle_dir(delta)
	handle_jump(delta)
	
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	
	move_and_slide()


func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_jump(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	elif Input.is_action_just_released("jump"):
		velocity.y = maxf(velocity.y, 0)

func handle_dir(delta):
	direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed * delta * 100, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, decceleration)
