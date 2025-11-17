extends AudioStreamPlayer 

var buildingButtonAudioStreamPlayer: AudioStreamPlayer
var generateButtonAudioStreamPlayer: AudioStreamPlayer

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
		
