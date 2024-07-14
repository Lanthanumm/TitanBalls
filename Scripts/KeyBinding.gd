extends VBoxContainer


@export var key_bind_panel: Panel
var listen_for_input: bool

var selected_action: String
var selected_action_btn: Button

func _ready() -> void:
	key_bind_panel.visible = false
	
	for child in get_children():
		if child is HBoxContainer:
			var btn = child.get_child(1)
			btn.button_up.connect(_on_key_up.bind(child.name))
			btn.text = InputMap.action_get_events(child.name)[0].as_text()

func _on_key_up(node_name: String) -> void:
	listen_for_input = true
	selected_action_btn = get_node(node_name + "/Button")
	selected_action = node_name
	key_bind_panel.visible = true

func can_bind(event: InputEvent) -> bool:
	if (event is InputEventKey || event is InputEventMouseButton) && !event.is_action_pressed("click") && listen_for_input && selected_action_btn != null:
		return true
	else: 
		return false
	 

func _input(event: InputEvent) -> void:
	if can_bind(event) && !event.is_action_pressed("back"):
		InputMap.action_erase_events(selected_action)
		InputMap.action_add_event(selected_action, event)
		
		selected_action_btn.text = event.as_text()
		
		listen_for_input = false
		key_bind_panel.visible = false
	
	elif event.is_action_pressed("back"):
		listen_for_input = false
