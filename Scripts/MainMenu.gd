extends Control


@export var applying_panel: Panel

@export var main_controls: VBoxContainer
@export var options_nav: HBoxContainer

@export var options_vbox: VBoxContainer

var main_panels = []
var options_tab = []

enum CurrentPanel {
	CHAR_SELECTOR,
	OPTIONS,
	EXTRA,
	NONE
}

enum CurrentTab {
	DISPLAY,
	CONTROLS,
	SOUNDS,
	KEY_BINDING,
}


func _ready() -> void:
	for panel in get_tree().root.get_child(0).get_children():
		if panel is PanelContainer:
			main_panels.append(panel)
	
	for tab in CurrentTab.size():
		var vbox = options_vbox.get_child(tab + 2)
		options_tab.append(vbox)
	
	
	for btn in main_controls.get_children():
		btn.button_up.connect(set_panel.bind(btn.get_index()))
	
	for btn in options_nav.get_children():
		btn.button_up.connect(set_tab.bind(btn.get_index()))
	
	set_default()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("back") && !options_tab[CurrentTab.KEY_BINDING].listen_for_input:
		set_default()

func _on_quit_up() -> void:
	get_tree().quit()


func set_panel(current_panel: CurrentPanel):
	for i in main_panels.size():
		if main_panels[i] != null:
			main_panels[i].visible = true if i == current_panel && current_panel != CurrentPanel.NONE else false

func set_tab(current_tab: CurrentTab):
	for i in options_tab.size():
		if options_tab[i] != null:
			options_tab[i].visible = true if i == current_tab else false

func set_default():
	set_panel(CurrentPanel.NONE)
	set_tab(CurrentTab.DISPLAY)
