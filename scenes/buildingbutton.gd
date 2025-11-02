extends Control

class_name BuildingButton

@export var building:Building
@export var icon = null
@export var disabled = true

@onready var button = $Button

var totalsResource: TotalsResourceTemplate = preload("res://resources/totals/totals_resource.tres")

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
		var currentTotal = totalsResource.current_value - building.current_cost
		totalsResource.current_value = currentTotal
		totalsResource.currentTickIncrementValue = totalsResource.currentTickIncrementValue + self.building.factory_multiplier
		building.factory_count += 1
		building.current_cost = building.current_cost * building.flat_multiplier
		update()

	
func update():
	if (building):
		cost_label.text = str(building.current_cost)
		owned_label.text =str( building.factory_count)
		name_label.text = building.name
		
		if (totalsResource && self.building && self.building.current_cost):
			var currentTotal = totalsResource.current_value
			if (currentTotal >= self.building.current_cost):
				disabled = false
			else:
				disabled = true
			button.disabled = disabled


func _on_button_pressed() -> void:
	buy()
