extends Node


const SETTINGS_FILE_NAME = "user://settings.save"

var key_bindings := {}


func _ready() -> void:
	for action in InputMap.get_actions():
		if !action.split("_")[0] == "ui":
			key_bindings[action] = InputMap.action_get_events(action)

func save_file():
	for action in InputMap.get_actions():
		if !action.split("_")[0] == "ui":
			key_bindings[action] = InputMap.action_get_events(action)
	
	var file = FileAccess.open(SETTINGS_FILE_NAME, FileAccess.WRITE)
	file.store_var(key_bindings)

func load_file():
	var file = FileAccess.open(SETTINGS_FILE_NAME, FileAccess.READ)
	print(file.get_var())
