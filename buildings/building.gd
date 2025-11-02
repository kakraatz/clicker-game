extends Resource

class_name Building

@export var id = 0
@export var factory_count = 0
@export var factory_multiplier = 0
@export var initial_cost = 0
@export var current_cost = 0
@export var button_label = ""
@export var name = ""
@export var flat_multiplier = 1.3


func buy_building():
	factory_count += 1
	current_cost = current_cost * flat_multiplier
	button_label = self.name + ' ' + str(current_cost)
