extends Resource

class_name Building

@export var id = 0
@export var factory_count = 0
const base_gold_multiplier = 10
const base_exponent_constant = 1.2
var gold_multiplier = 0
@export var button_label = ""
@export var name = ""
@export var flat_multiplier = 2
@export var flat_base_cost = 50
var initial_cost = 0
var unlocked = false
var current_cost = 0

const base_gold_output: Array[int] = [1, 5, ]

func _init():
	calculate_initial_cost()
	
func unlock_building(current_gold):
	if current_gold >= self.initial_cost:
		self.unlocked = true
		return true
	else:
		return false

func buy_building():
	factory_count += 1
	current_cost = current_cost * flat_multiplier
	button_label = self.name + ' ' + str(current_cost)
	
func save():
	var json_dictionary = {}
	
	json_dictionary["id"] = self.id
	json_dictionary["factory_count"] = self.factory_count
	json_dictionary["factory_multiplier"] = self.factoryMultiplier
	json_dictionary["initial_cost"] = self.initial_cost
	json_dictionary["current_cost"] = self.current_cost
	json_dictionary["name"] = self.name
	json_dictionary["flat_multiplier"] = self.factoryMultiplier
	
	var json_string = JSON.stringify(json_dictionary)
	#data = {key: getattr(Building, key) for key in Building.annotations}

	return json_string
	
static func load(json):
	var new_building = Building.new()
	
	var id = json["id"]
	var factory_count = json["factory_count"]
	var base_gold_multiplier = json["base_gold_multiplier"]
	var initial_cost = json["initial_cost"]
	var current_cost = json["current_cost"]
	var name = json["name"]
	var flat_multiplier = json["flat_multiplier"]

	new_building.id = id
	new_building.factory_count = factory_count
	new_building.base_gold_multiplier = base_gold_multiplier
	new_building.initial_cost = initial_cost
	new_building.current_cost = current_cost
	new_building.name = name
	new_building.flat_multiplier = flat_multiplier
	
	return new_building
	

func calculate_initial_cost():
	if self.id == 1:
		self.initial_cost = 10
	elif self.id == 2:
		self.initial_cost = 20
	else:
		self.initial_cost = flat_base_cost * (flat_multiplier ** self.id)
	self.current_cost = self.initial_cost
	
func calculate_base_gold_multiplier():
	self.gold_multiplier = base_gold_multiplier * base_exponent_constant**(self.id -1)
	
	
