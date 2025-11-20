extends Control

class_name BuildingButton

@export var building:Building
@export var icon = null
@export var disabled = true

@onready var button = $Button

var game_state_resource: GameStateTemplate = preload("res://resources/totals/game_state_resource.tres")

@onready var cost_label: Label = $Button/CostLabel
@onready var name_label: Label = $Button/NameLabel
@onready var owned_label: Label = $Button/OwnedLabel

func _init():
	if (building):
		print(building)
		cost_label.text = building.current_cost
		name_label.text = building.name
		owned_label.text = building.factory_count
		
func buy():
	if !self.disabled:
		var current_gold = game_state_resource.current_gold - building.current_cost
		game_state_resource.current_gold = current_gold
		game_state_resource.current_tick_increment_value = game_state_resource.current_tick_increment_value + self.building.flat_multiplier
		building.factory_count += 1
		building.current_cost = building.current_cost * building.flat_multiplier
		
		#if (building.factory_count == 1):
			#game_state_resource.allBuildings.append(building)
			#print('saved building to array')
		update()

	
func update():
	if (building):
		cost_label.text = str(building.current_cost)
		owned_label.text =str( building.factory_count)
		name_label.text = building.name
		
		if (game_state_resource && self.building && self.building.current_cost):
			var current_gold = game_state_resource.current_gold
			if (current_gold >= self.building.current_cost):
				disabled = false
			else:
				disabled = true
			button.disabled = disabled


func _on_button_pressed() -> void:
	buy()
	AudioManager.on_building_button_pressed()
