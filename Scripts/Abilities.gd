extends Node2D

@onready var player_node = $".."

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ability_1") && !player_node.is_dashing:
		char1_ability1()
	elif event.is_action_pressed("ability_2") && player_node.is_on_floor():
		char1_ability2()
	elif event.is_action_pressed("ability_3"):
		ability_3()

func char1_ability1():
	player_node.is_dashing = true
	player_node.velocity.y = 0
	
	player_node.anim.play("dash")
	player_node.current_anim = player_node.CurrentAnim.DASH
	
	var direction = 1 if get_viewport().get_mouse_position().x > get_viewport().size.x / 2 else -1
	player_node.velocity.x = direction * player_node.dash_velocity

func char1_ability2():
	player_node.velocity.y += player_node.jump_velocity * 1.5
	
	player_node.anim.play("dash")
	player_node.current_anim = player_node.CurrentAnim.DASH
	
	var direction = 1 if get_viewport().get_mouse_position().x > get_viewport().size.x / 2 else -1
	player_node.velocity.x += direction * player_node.huge_jump_speed

func ability_3():
	pass
