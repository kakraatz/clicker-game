extends Node

var game_state_resource: GameStateTemplate = preload("res://resources/totals/game_state_resource.tres")
var save_path: String = "user://saveFile.dat"

func save_game_state():
	print('in save_game_state')
	var current_gold = game_state_resource.current_gold
	var all_buildings = game_state_resource.all_buildings
	var json_dictionary = {}
	
	json_dictionary["current_gold"] = current_gold
	
	var building_json_array = []
	for building in all_buildings:
		var building_json_string = building.save()
		var building_json  = JSON.parse_string(building_json_string)
		building_json_array.append(building_json)
	
	json_dictionary["all_buildings"] = building_json_array
	
	var json = JSON.stringify(json_dictionary)

	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(json)
	file.close()
	
func loadGameState():
	print('loading saved file')
	#ResourceLoader.load("res://saveFile.res")
	var file = FileAccess.open(save_path, FileAccess.READ)
	if file:
		var data = file.get_var()
		
		var saved_data = JSON.parse_string(data)
	
		if saved_data:
			game_state_resource.current_gold = saved_data["current_gold"]
			var all_buildingsJSON = saved_data["all_buildings"]
			
			var all_buildings: Array[Building] = []
			for building_json in all_buildingsJSON:
				var loaded_building: Building = Building.load(building_json)
				all_buildings.append(loaded_building)
				
			if all_buildings:
				game_state_resource.all_buildings = all_buildings
		file.close()
		
		
