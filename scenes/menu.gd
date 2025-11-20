extends Node

class_name GameMenu

signal quit_signal
signal resume_signal

@onready var options_menu_scene: PackedScene = preload("res://scenes/option_menu.tscn")
@onready var menu_scene: GameMenu = $"."

var game_started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_options_button_pressed() -> void:
	var options_menu_scene_instance = options_menu_scene.instantiate()
	menu_scene.add_child(options_menu_scene_instance)

func _on_quit_button_pressed() -> void:
	quit_signal.emit()
	get_tree().quit()

func _on_resume_button_pressed() -> void:
	resume_signal.emit()
	queue_free()
