extends Resource

class_name Building

@export var id = 0
@export var factoryCount = 0
@export var factoryMultiplier = 0
@export var initialCost = 0
@export var currentCost = 0
@export var buttonLabel = ""
@export var name = ""
@export var flatMultiplier = 1.3
var unlocked = false

func init(factoryMultiplier, initialCost, name):
	self.factoryMultiplier = factoryMultiplier
	self.initialCost = initialCost
	self.name = name
	
func unlock_building(currentGold):
	if currentGold >= self.initialCost:
		self.unlocked = true
		return true
	else:
		return false

func buy_building():
	factoryCount += 1
	currentCost = currentCost * flatMultiplier
	buttonLabel = self.name + ' ' + str(currentCost)
	
func save():
	var jsonDictionary = {}
	
	jsonDictionary["id"] = self.id
	jsonDictionary["factory_count"] = self.factoryCount
	jsonDictionary["factory_multiplier"] = self.factoryMultiplier
	jsonDictionary["initial_cost"] = self.initialCost
	jsonDictionary["current_cost"] = self.currentCost
	jsonDictionary["name"] = self.name
	jsonDictionary["flat_multiplier"] = self.factoryMultiplier
	
	var jsonString = JSON.stringify(jsonDictionary)
	#data = {key: getattr(Building, key) for key in Building.annotations}

	return jsonString
	
static func load(json):
	var newBuilding = Building.new()
	
	var id = json["id"]
	var factoryCount = json["factory_count"]
	var factoryMultiplier = json["factory_multiplier"]
	var initialCost = json["initial_cost"]
	var currentCost = json["current_cost"]
	var name = json["name"]
	var flatMultiplier = json["flat_multiplier"]

	newBuilding.id = id
	newBuilding.factoryCount = factoryCount
	newBuilding.factoryMultiplier = factoryMultiplier
	newBuilding.initialCost = initialCost
	newBuilding.currentCost = currentCost
	newBuilding.name = name
	newBuilding.flatMultiplier = flatMultiplier
	
	return newBuilding
	

	#var allBuiildingsJSON = jsonString[all_buildings]
	#var jsonDictionary = JSON.parse_string(allBuiildingsJSON)
	#var allBuildings = jsonDictionat
	#
	#var id = jsonString["id"]
	#
	#var building = Building.new()
	
