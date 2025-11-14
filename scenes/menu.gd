extends Node

class_name GameMenu
signal quitSignal

@onready var startButton = $Button_Manager/GridContainer/Start_Button
var gameStarted = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if gameStarted:
		startButton.text = 'RESUME'


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	if (!gameStarted):
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	else:
		queue_free()

func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	quitSignal.emit()
	get_tree().quit()
