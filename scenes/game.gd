extends Node2D
@onready var cycle_interval = $Cycle_Interval
@onready var factory1_button = $Factory1_Button as Button
@onready var building1_button = $BuildingButton1 as Button
@export var value_count = 0
var flat_multiplier = 1.32
var factory1 = Factory_1.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cycle_interval.timeout.connect(run_tick)
	factory1_button.text = factory1.button_label
	building1_button.building = factory1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Current_Value_Label.text = 'VALUE: ' + str(value_count)
	can_buy(factory1.current_cost, factory1_button)

func _on_generate_value_button_pressed() -> void:
	value_count += 1
	#print(value_count)
	
func run_tick():
	#print("running")
	value_count = value_count + (factory1.factory_count * factory1.factory_multiplier)
	
func can_buy(current_cost, button) -> bool:
	if value_count >= current_cost:
		button.disabled = false
		return true
	else:
		button.disabled = true
		return false
	
func _on_factory_1_button_pressed() -> void:
	if can_buy(factory1.current_cost, factory1_button):
		value_count -= factory1.current_cost
		factory1.buy_building()
		factory1_button.text = factory1.button_label
		
