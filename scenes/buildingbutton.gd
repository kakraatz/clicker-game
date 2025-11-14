extends Control

class_name BuildingButton

@export var building:Building
@export var icon = null
@export var disabled = true

@onready var button = $Button

var gameStateResource: GameStateTemplate = preload("res://resources/totals/game_state_resource.tres")

@onready var costLabel: Label = $Button/CostLabel
@onready var nameLabel: Label = $Button/NameLabel
@onready var ownedLabel: Label = $Button/OwnedLabel

func _init():
	if (building):
		print(building)
		costLabel.text = building.currentCost
		nameLabel.text = building.name
		ownedLabel.text = building.factoryCount
		
func buy():
	if !self.disabled:
		var currentGold = gameStateResource.currentGold - building.currentCost
		gameStateResource.currentGold = currentGold
		gameStateResource.currentTickIncrementValue = gameStateResource.currentTickIncrementValue + self.building.factoryMultiplier
		building.factoryCount += 1
		building.currentCost = building.currentCost * building.flatMultiplier
		
		#if (building.factory_count == 1):
			#gameStateResource.allBuildings.append(building)
			#print('saved building to array')
		update()

	
func update():
	if (building):
		costLabel.text = str(building.currentCost)
		ownedLabel.text =str( building.factoryCount)
		nameLabel.text = building.name
		
		if (gameStateResource && self.building && self.building.currentCost):
			var currentGold = gameStateResource.currentGold
			if (currentGold >= self.building.currentCost):
				disabled = false
			else:
				disabled = true
			button.disabled = disabled


func _on_button_pressed() -> void:
	buy()
