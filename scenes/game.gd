extends Node2D
var value_count = 0
var factory1_count = 0
var factory1_multiplier = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	run_tick()
	$Current_Value_Label.text = 'VALUE: ' + str(value_count)
	

func _on_generate_value_button_pressed() -> void:
	value_count+=1
	print(value_count)
	
func run_tick():
	value_count = value_count + (factory1_count * factory1_multiplier)
	
	
func _on_factory_1_button_pressed() -> void:
		factory1_count+=1
