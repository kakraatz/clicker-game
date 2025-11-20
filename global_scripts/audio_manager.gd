extends AudioStreamPlayer 

var buildingButtonAudioStreamPlayer: AudioStreamPlayer
var generateButtonAudioStreamPlayer: AudioStreamPlayer

signal master_bus_volume_changed_signal
signal sfx_bus_volume_changed_signal
signal music_bus_volume_changed_signal

func createAudioStreamPlayers():
	var audioStreamPlayerArray = []
	var buildingButtonAudioStreamPlayer = createBuildingButtonAudioStreamPlayer()
	var generateButtonAudioStreamPlayer = createGenerateButtonAudioStreamPlayer()
	
	audioStreamPlayerArray.append(buildingButtonAudioStreamPlayer)
	audioStreamPlayerArray.append(generateButtonAudioStreamPlayer)
	
	return audioStreamPlayerArray
	

func createBuildingButtonAudioStreamPlayer() -> AudioStreamPlayer:
	var buildingButtonAudioStreamPlayer: AudioStreamPlayer = AudioStreamPlayer.new()
	buildingButtonAudioStreamPlayer.stream = preload("res://audio/sound_effects/building_button_sound.mp3")
	AudioManager.buildingButtonAudioStreamPlayer = buildingButtonAudioStreamPlayer
	return buildingButtonAudioStreamPlayer
	
func createGenerateButtonAudioStreamPlayer() -> AudioStreamPlayer:
	var generateButtonAudioStreamPlayer: AudioStreamPlayer = AudioStreamPlayer.new()
	generateButtonAudioStreamPlayer.stream = preload("res://audio/sound_effects/generate_button_sound.mp3")
	AudioManager.generateButtonAudioStreamPlayer = generateButtonAudioStreamPlayer
	return generateButtonAudioStreamPlayer

func on_building_button_pressed():
	buildingButtonAudioStreamPlayer.play(0.0)
	
func on_generate_button_pressed():
	generateButtonAudioStreamPlayer.play(0.0)
		
func change_master_audio_bus_volume(volume: float):
	var master_bus_index: int =  AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(volume))
	
func change_sfx_audio_bus_volume(volume: float):
	var sfx_bus_index: int =  AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(volume))
	
func change_music_audio_bus_volume(volume: float):
	var music_bus_index: int =  AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(volume))
