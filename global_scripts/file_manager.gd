extends Node

var totalsResource: TotalsResourceTemplate = preload("res://resources/totals/totals_resource.tres")
var savePath: String = "user://saveFile.dat"

func saveGameState():
	print('in saveGameState')
	var currentValue = totalsResource.current_value

	var file = FileAccess.open(savePath, FileAccess.WRITE)
	file.store_var(currentValue)
	#
	## Save building data
	var allBuildings = totalsResource.allBuildings
	if allBuildings && allBuildings.size() > 0:
		file.store_var(allBuildings)
		#print('should have saved buildings')
		#file.store_var(allBuildings.size())
		#for  building in allBuildings:
			#file.store_var(building)
	file.close()
	get_tree().quit()
	
func loadGameState():
	print('loading saved file')
	#ResourceLoader.load("res://saveFile.res")
	var file = FileAccess.open(savePath, FileAccess.READ)
	if file:
		var currentValue = file.get_var()
		if currentValue:
			totalsResource.current_value = currentValue
		var allBuildings = file.get_var()
		var newBuildingArray: Array[Building] = []
		if allBuildings:
			var buildingsArray: Array[EncodedObjectAsID] = allBuildings
			for encodedID in buildingsArray:
				var id = encodedID.object_id
				var instance = instance_from_id(id)
				print('here')
				print(instance)
				newBuildingArray.append(instance)

			#totalsResource.allBuildings = buildingsArray
		print(newBuildingArray)
		file.close()
