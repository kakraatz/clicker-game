extends Node

class_name GameMenu
signal quit_signal

@onready var startButton = $Button_Manager/GridContainer/Start_Button
var game_started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if game_started:
		startButton.text = 'RESUME'


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	if (!game_started):
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	else:
		queue_free()

func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	quit_signal.emit()
	get_tree().quit()
