extends Node

signal quitSignal

@onready var cycle_interval: Timer = $Cycle_Interval
@onready var gameControlNode: Control = $"."
@onready var goldValueLabel: Label = $ValueControl/Current_Value_Label
@onready var menuScene: PackedScene = preload("res://scenes/menu.tscn")
@onready var buildingManagerNode: Node = $BuildingManger

var flat_multiplier = 1.32
var totalsResource: TotalsResourceTemplate = preload("res://resources/totals/totals_resource.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FileManager.loadGameState()
	if !totalsResource:
		totalsResource = preload("res://resources/totals/totals_resource.tres")
	quitSignal.connect(quitGame)
	buildingManagerNode.connect("toggleVisibilitySignal", Callable(buildingManagerNode ,"toggleVisibilitySignal"))
	cycle_interval.timeout.connect(run_tick)
	
	get_tree().auto_accept_quit = false
	
	print(get_tree().auto_accept_quit)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var currentValue = totalsResource.current_value
	if goldValueLabel:
		goldValueLabel.text = 'VALUE: ' + str(currentValue)
	#can_buy(factory1.current_cost, factory1_button)

func _on_generate_value_button_pressed() -> void:
	totalsResource.current_value = totalsResource.current_value + 1
	print(totalsResource.current_value)
	
func run_tick():
	#print("running")
	var current_value = totalsResource.current_value
	var currentTickIncrementAmount = totalsResource.currentTickIncrementValue
	totalsResource.current_value = current_value + totalsResource.currentTickIncrementValue

func toggleBuildingUIVisability() -> void:
	if gameControlNode:
		buildingManagerNode.emit_signal("toggleVisibilitySignal")
	else:
		print('no node')

func _on_menu_button_pressed() -> void:
	if gameControlNode:
		toggleBuildingUIVisability()
		var menu = menuScene.instantiate()
		menu.gameStarted = true
		menu.connect("quitSignal", quitGame)
		gameControlNode.add_child(menu)
	else:
		print('no node')
		
func quitGame():
	FileManager.saveGameState()

func _exit_tree() -> void:
	FileManager.saveGameState()
	
#func _notification(what):
	#if what == NOTIFICATION_WM_CLOSE_REQUEST:
		#saveGameState()
	
#func _notification(notification) -> void:
	#print("[+] CURRENT REQUEST: ", notification)
	
