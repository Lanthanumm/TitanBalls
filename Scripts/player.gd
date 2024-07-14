extends CharacterBody2D

@export var speed = 300.0
@export var decceleration = 60.0
@export var acceleration = 60.0

@export var jump_velocity = -400.0
@export var gravity = 2950
@export var fall_threshold: int

@export var dash_velocity = 300
@export var huge_jump_speed = 300

@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite

var direction: float
var is_dashing: bool

enum CurrentAnim {IDLE, WALK, JUMP, FALL, DASH}
var current_anim: CurrentAnim

func _physics_process(delta: float) -> void:
	if !is_dashing:
		handle_dir()
		handle_vertical_dir(delta)
	else:
		velocity.x = move_toward(velocity.x, 0, decceleration)
	
	if abs(velocity.x) <= speed:
		is_dashing = false
	if Input.is_action_just_pressed("ability_2") && current_anim != CurrentAnim.DASH && velocity.y < jump_velocity:
		anim.play("dash")
		current_anim = CurrentAnim.DASH
	
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	
	move_and_slide()



func handle_vertical_dir(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		anim.play("jump")
		current_anim = CurrentAnim.JUMP
	
	if velocity.y > fall_threshold  && current_anim != CurrentAnim.FALL:
		anim.play("fall")
		current_anim = CurrentAnim.FALL

func handle_dir():
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, acceleration)
		if is_on_floor():
			anim.play("walk")
			current_anim = CurrentAnim.WALK
	
	else:
		velocity.x = move_toward(velocity.x, 0, decceleration)
		if is_on_floor():
			anim.play("idle")
			current_anim = CurrentAnim.IDLE
