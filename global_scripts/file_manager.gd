extends Node

var gameStateResource: GameStateTemplate = preload("res://resources/totals/game_state_resource.tres")
var savePath: String = "user://saveFile.dat"

func saveGameState():
	print('in saveGameState')
	var currentGold = gameStateResource.currentGold
	var allBuildings = gameStateResource.allBuildings
	var jsonDictionary = {}
	
	jsonDictionary["current_gold"] = currentGold
	
	var buildingJSONArray = []
	for building in allBuildings:
		var buildingJSONString = building.save()
		var buildingJSON  = JSON.parse_string(buildingJSONString)
		buildingJSONArray.append(buildingJSON)
	
	jsonDictionary["all_buildings"] = buildingJSONArray
	
	var json = JSON.stringify(jsonDictionary)

	var file = FileAccess.open(savePath, FileAccess.WRITE)
	file.store_var(json)
	file.close()
	
func loadGameState():
	print('loading saved file')
	#ResourceLoader.load("res://saveFile.res")
	var file = FileAccess.open(savePath, FileAccess.READ)
	if file:
		var data = file.get_var()
		
		var savedData = JSON.parse_string(data)
	
		if savedData:
			gameStateResource.currentGold = savedData["current_gold"]
			var allBuildingsJSON = savedData["all_buildings"]
			
			var allBuildings: Array[Building] = []
			for buildingJSON in allBuildingsJSON:
				var loadedBuilding: Building = Building.load(buildingJSON)
				allBuildings.append(loadedBuilding)
				
			if allBuildings:
				gameStateResource.allBuildings = allBuildings
		file.close()
		
		
