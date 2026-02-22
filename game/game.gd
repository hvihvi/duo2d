extends Node2D


func _ready() -> void:
	var home_scene = load("res://game/home/home_screen.tscn")
	add_child(home_scene.instantiate())
