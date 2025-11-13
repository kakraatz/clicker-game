extends Node

@export var currentBuildings: Array[Building]
signal toggleVisibilitySignal

@onready var vboxContainer = $Control/Panel/ScrollContainer/VBoxContainer
@onready var control = $Control

var totalsResource: TotalsResourceTemplate = preload("res://resources/totals/totals_resource.tres")
var buildingButtonScene: PackedScene = preload("res://scenes/buildingbutton.tscn")
var allBuildingResources: Array[Building] = [
	preload("res://resources/buildings/farm_building_resource.tres"),
	preload("res://resources/buildings/temple_building_resource.tres"),
]

var value 
var buildingButtons: Array[BuildingButton] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	toggleVisibilitySignal.connect(toggleVisibility)	
	#Creates building buttons for each building that is passed in
	if (currentBuildings):
		for building in currentBuildings:
			createBuildingButton(building)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# TODO replace this logic with signals for better performance 
	var currentValue = totalsResource.current_value
	if (buildingButtons):
		for buildingButton in buildingButtons:
			buildingButton.update()
			
func can_buy(current_cost, button) -> bool:
	if value >= current_cost:
		button.disabled = false
		return true
	else:
		button.disabled = true
		return false
	
# Instantiates a new button to the scene tree
func createBuildingButton(buildingResource: Building):
	var buildingButton: BuildingButton = buildingButtonScene.instantiate()
	buildingButton.building = buildingResource
	if (vboxContainer):
		vboxContainer.add_child(buildingButton)
		buildingButton.update()
		buildingButtons.append(buildingButton)
	else:
		printerr('Missing vboxContainer')
		
func toggleVisibility():
	if control:
		if control.visible:
			print('hide')
			control.visible = false
		else:
			control.visible = true
			print('show')
	else:
		printerr('No control')
