extends Node2D

# Maps level number to its scene path
const LEVEL_SCENES = {
	1: "res://levels/level_1.tscn",
}

var has_save: bool = false
var current_selection: int = 0


func _ready() -> void:
	has_save = SaveManager.has_save()

	if has_save:
		%ContinueButton.pressed.connect(_on_continue_pressed)
	else:
		%ContinueButton.hide()

	%NewGameButton.pressed.connect(_on_new_game_pressed)
	%BackButton.pressed.connect(_on_back_pressed)

	current_selection = 0 if has_save else 1
	_focus_current()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		get_viewport().set_input_as_handled()
		if current_selection == 0:
			current_selection = 1
			%NewGameButton.grab_focus()
		elif current_selection == 1:
			current_selection = 2
			%BackButton.grab_focus()
		elif current_selection == 2:
			current_selection = 0 if has_save else 1
			_focus_current()
	elif event.is_action_pressed("ui_up"):
		get_viewport().set_input_as_handled()
		if current_selection == 0:
			current_selection = 2
			%BackButton.grab_focus()
		elif current_selection == 1:
			current_selection = 0 if has_save else 2
			_focus_current()
		elif current_selection == 2:
			current_selection = 1
			%NewGameButton.grab_focus()
	elif event.is_action_pressed("ui_accept"):
		get_viewport().set_input_as_handled()
		if current_selection == 0:
			_on_continue_pressed()
		elif current_selection == 1:
			_on_new_game_pressed()
		elif current_selection == 2:
			_on_back_pressed()


func _focus_current() -> void:
	if current_selection == 0:
		%ContinueButton.grab_focus()
	elif current_selection == 1:
		%NewGameButton.grab_focus()
	elif current_selection == 2:
		%BackButton.grab_focus()


func _on_continue_pressed() -> void:
	var save = SaveManager.load_save()
	var level = save.get("level", 1)
	get_tree().change_scene_to_file(LEVEL_SCENES[level])


func _on_new_game_pressed() -> void:
	SaveManager.delete_save()
	SaveManager.save_level(1)
	get_tree().change_scene_to_file(LEVEL_SCENES[1])


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://game/home/home_screen.tscn")
