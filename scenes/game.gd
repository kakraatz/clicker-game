extends Node

@onready var cycle_interval: Timer = $Cycle_Interval
@onready var gameControlNode: Control = $"."
@onready var goldValueLabel: Label = $ValueControl/Current_Value_Label
@onready var menuScene: PackedScene = preload("res://scenes/menu.tscn")

var flat_multiplier = 1.32
var totalsResource: TotalsResourceTemplate = preload("res://resources/totals/totals_resource.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cycle_interval.timeout.connect(run_tick)
	
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

func _on_menu_button_pressed() -> void:
	if gameControlNode:
		var menu = menuScene.instantiate()
		menu.gameStarted = true
		gameControlNode.add_child(menu)
	else:
		print('no node')
