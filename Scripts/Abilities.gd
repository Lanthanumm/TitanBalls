extends Node2D

@onready var player_node = $".."

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ability_1") && player_node.direction && !player_node.is_dashing:
		ability_1()
	elif event.is_action_pressed("ability_2") && player_node.is_on_floor():
		ability_2()
	elif event.is_action_pressed("ability_3"):
		ability_3()

func ability_1():
	player_node.is_dashing = true
	player_node.velocity.y = 0
	
	player_node.anim.play("dash")
	
	var direction = 1 if !player_node.sprite.flip_h else -1
	player_node.velocity.x = direction * player_node.dash_velocity

func ability_2():
	var doubled_jump_velocity = player_node.jump_velocity * 1.5
	player_node.velocity.y += doubled_jump_velocity

func ability_3():
	pass
