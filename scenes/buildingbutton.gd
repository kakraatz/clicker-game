extends Node2D

class_name BuildingButton

@export var building:Building
@export var icon = null
@export var disabled = true

@onready var cost_label = $Button/CostLabel
@onready var name_label = $Button/NameLabel
@onready var owned_label = $Button/OwnedLabel

func _init():
	cost_label = building.current_cost
	name_label = building.name
	owned_label = building.factory_count
	
func update_labels():
	cost_label = building.current_cost
	owned_label = building.factory_count
