extends Node

@onready var player_node = $".."

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ability_1"):
		ability1()
	elif event.is_action_pressed("ability_2") && player_node.is_on_floor():
		ability2()
	elif event.is_action_pressed("ability_3"):
		ability_3()

func ability1():
	pass

func ability2():
	if player_node.is_on_floor():
		player_node.velocity.y += player_node.jump_velocity * 1.5
		
		var direction = 1 if get_viewport().get_mouse_position().x > get_viewport().size.x / 2 else -1
		player_node.velocity.x = direction * player_node.huge_jump_speed

func ability_3():
	pass
