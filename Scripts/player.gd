extends CharacterBody2D

@export var speed = 300.0
@export var jump_velocity = -400.0

@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if direction > 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
	
		velocity.x = direction * speed
		if is_on_floor():
			anim.play("walk")
	
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if is_on_floor():
			anim.play("idle")
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		anim.play("jump")
	
	if velocity.y > 50:
		anim.play("fall")
	
	move_and_slide()
