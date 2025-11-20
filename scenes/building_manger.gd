extends Node

class_name BuildingManager

@export var current_buildings: Array[Building]

signal toggleVisibilitySignal
signal update_buttons_signal

@onready var vbox_container = $Control/Panel/ScrollContainer/VBoxContainer
@onready var control = $Control

var game_state_resource: GameStateTemplate = preload("res://resources/totals/game_state_resource.tres")
var building_button_scene: PackedScene = preload("res://scenes/buildingbutton.tscn")
var all_buildings_unlockable: Array[Building] = [
	#preload("res://resources/buildings/farm_building_resource.tres"),
	preload("res://resources/buildings/church_building_resource.tres"),
	preload("res://resources/buildings/woodcutter_building_resource.tres")
]
var farm_building_resource = preload("res://resources/buildings/farm_building_resource.tres")

var value 
var building_buttons: Array[BuildingButton] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	toggleVisibilitySignal.connect(toggle_visibility)
	update_buttons_signal.connect(update_all_buttons)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# TODO replace this logic with signals for better performance 
	var current_gold = game_state_resource.current_gold
	if (building_buttons):
		for building_button in building_buttons:
			building_button.update()
	for building in all_buildings_unlockable:
		unlockBuilding(building)
			
func can_buy(current_cost, button) -> bool:
	if value >= current_cost:
		button.disabled = false
		return true
	else:
		button.disabled = true
		return false
	
# Instantiates a new button to the scene tree
func create_building_button(building_resource: Building):
	var building_button: BuildingButton = building_button_scene.instantiate()
	building_button.building = building_resource
	if (vbox_container):
		vbox_container.add_child(building_button)
		building_button.update()
		building_buttons.append(building_button)
	else:
		printerr('Missing vbox_container')
		
func toggle_visibility():
	if control:
		if control.visible:
			print('hide')
			control.visible = false
		else:
			control.visible = true
			print('show')
	else:
		printerr('No control')
		
func createButtons(): 
	var current_buildings = game_state_resource.all_buildings
	#Creates building buttons for each building that is passed in
	if (current_buildings.is_empty()):
		farm_building_resource.calculate_initial_cost()
		create_building_button(farm_building_resource)
		var new_farm: Building = load("res://resources/buildings/farm_building_resource.tres") as Building
		current_buildings.append(new_farm)
		game_state_resource.all_buildings = current_buildings
	elif (current_buildings):
		for building in current_buildings:
			building.calculate_initial_cost()
			create_building_button(building)

		
func update_all_buttons():
	for building in all_buildings_unlockable:
		building.calculate_initial_cost()
	for building_button in building_buttons:
		building_button.update()
		calculate_gold_per_tick()
		
func calculate_gold_per_tick():
	var current_buildings = game_state_resource.all_buildings
	var current_gold_per_tick = 0.0
	
	for building in current_buildings:
		var building_gold_per_tick_value = building.base_gold_multiplier
		var building_count = building.factory_count
		var building_gold_per_tick = building_gold_per_tick_value * building_count
		current_gold_per_tick = current_gold_per_tick + building_gold_per_tick
	
	game_state_resource.current_tick_increment_value = current_gold_per_tick
	
func unlockBuilding(building: Building):
	for building_object in game_state_resource.all_buildings:
		if building_object.id == building.id:
			return
		elif building.unlocked == false:
			if building.unlock_building(game_state_resource.current_gold) == true:
				game_state_resource.all_buildings.append(building)
				create_building_button(building)
				building.unlocked = true
		else:
			return
			
func checkBuilding():
	for template in all_buildings_unlockable:
		for building in game_state_resource.all_buildings:
			if template.id == building.id:
				template.unlocked = true
