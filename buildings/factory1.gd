extends Building

class_name Factory_1

func _init():
	id = 1
	factory_count = 0
	factory_multiplier = 1
	initial_cost = 10
	current_cost = initial_cost
	name = "Factory 1"
	button_label = self.name + ' ' + str(current_cost)
