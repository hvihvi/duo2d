extends Node2D

var current_selection: int = 0

func _ready() -> void:
	%PlayButton.pressed.connect(_on_play_pressed)
	%SettingsButton.pressed.connect(_on_settings_pressed)
	%QuitButton.pressed.connect(_on_quit_pressed)
	%PlayButton.grab_focus()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		get_viewport().set_input_as_handled()
		if current_selection == 0:
			current_selection = 1
			%SettingsButton.grab_focus()
		elif current_selection == 1:
			current_selection = 2
			%QuitButton.grab_focus()
		elif current_selection == 2:
			current_selection = 0
			%PlayButton.grab_focus()
	elif event.is_action_pressed("ui_up"):
		get_viewport().set_input_as_handled()
		if current_selection == 0:
			current_selection = 2
			%QuitButton.grab_focus()
		elif current_selection == 1:
			current_selection = 0
			%PlayButton.grab_focus()
		elif current_selection == 2:
			current_selection = 1
			%SettingsButton.grab_focus()
	elif event.is_action_pressed("ui_accept"):
		get_viewport().set_input_as_handled()
		if current_selection == 0:
			_on_play_pressed()
		elif current_selection == 1:
			_on_settings_pressed()
		elif current_selection == 2:
			_on_quit_pressed()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://game/home/resume/resume_screen.tscn")


func _on_settings_pressed() -> void:
	print("settings pressed")
	# TODO: open settings menu
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()
