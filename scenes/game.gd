extends Node

signal quit_signal

@onready var cycle_interval: Timer = $Cycle_Interval
@onready var game_control_node: Control = $"."
@onready var gold_value_label: Label = $ValueControl/Current_Value_Label
@onready var menu_scene: PackedScene = preload("res://scenes/menu.tscn")
@onready var building_manager_node: BuildingManager = $BuildingManger

var flat_multiplier = 1.32
var game_state_resource: GameStateTemplate = preload("res://resources/totals/game_state_resource.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FileManager.loadGameState()
	building_manager_node.createButtons()
	building_manager_node.checkBuilding()
	building_manager_node.emit_signal("update_buttons_signal")
	if !game_state_resource:
		game_state_resource = preload("res://resources/totals/game_state_resource.tres")
	quit_signal.connect(quitGame)
	building_manager_node.connect("toggleVisibilitySignal", Callable(building_manager_node ,"toggleVisibilitySignal"))
	cycle_interval.timeout.connect(run_tick)
	
	get_tree().auto_accept_quit = false
	
	initializeAudio()
	
	print(get_tree().auto_accept_quit)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var current_gold = game_state_resource.current_gold
	if gold_value_label:
		gold_value_label.text = 'VALUE: ' + str(current_gold)
	#can_buy(factory1.current_cost, factory1_button)

func _on_generate_value_button_pressed() -> void:
	game_state_resource.current_gold = game_state_resource.current_gold + 1
	AudioManager.on_generate_button_pressed()
	
	
func run_tick():
	#print("running")
	var current_gold = game_state_resource.current_gold
	game_state_resource.current_gold = current_gold + game_state_resource.current_tick_increment_value

func toggle_building_ui_visability() -> void:
	if game_control_node:
		building_manager_node.emit_signal("toggleVisibilitySignal")
	else:
		print('no node')

func _on_menu_button_pressed() -> void:
	if game_control_node:
		toggle_building_ui_visability()
		var menu = menu_scene.instantiate()
		menu.game_started = true
		menu.connect("quit_signal", quitGame)
		game_control_node.add_child(menu)
	else:
		print('no node')
		
func quitGame():
	FileManager.save_game_state()

func _exit_tree() -> void:
	FileManager.save_game_state()
	
func initializeAudio():
	var audioStreamPlayerArray = AudioManager.createAudioStreamPlayers()
	
	if audioStreamPlayerArray:
		for audioStreamPlayer in audioStreamPlayerArray:
			add_child(audioStreamPlayer)
	
	
#func _notification(what):
	#if what == NOTIFICATION_WM_CLOSE_REQUEST:
		#saveGameState()
	
#func _notification(notification) -> void:
	#print("[+] CURRENT REQUEST: ", notification)
	
