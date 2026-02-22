extends Node

const SAVE_PATH = "user://save.json"


func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)


func load_save() -> Dictionary:
	if not has_save():
		return {}
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	return data if data is Dictionary else {}


func save_level(level: int) -> void:
	var data = load_save()
	data["level"] = level
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()


func delete_save() -> void:
	if has_save():
		DirAccess.remove_absolute(SAVE_PATH)
