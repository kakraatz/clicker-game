extends Control
class_name OptionMenu

func _ready() -> void:
	AudioManager.connect("master_bus_volume_changed_signal", Callable(AudioManager ,"change_master_audio_bus_volume"))

func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioManager.master_bus_volume_changed_signal.emit(value)

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioManager.sfx_bus_volume_changed_signal.emit(value)

func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioManager.music_bus_volume_changed_signal.emit(value)

func _on_back_button_pressed() -> void:
	queue_free()
