extends Panel

var propertiesPanel = load("res://Menu/properties_menu_row.tscn")
var propertiesIndexID = 0
@export var propertiesList = []
@onready var propertiesContainer = $VBoxContainer/PanelContainer2/ScrollContainer/HBoxContainer/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_update_properties_list()

func _on_add_properties_pressed():
	var newRow = propertiesPanel.instantiate()
	newRow.propertiesID = propertiesIndexID
	propertiesIndexID += 1
	propertiesContainer.add_child(newRow)
	_on_update_properties_list()

func _on_update_properties_list():
	propertiesList = []
	for child in propertiesContainer.get_children():
		var propertiesData = {
			"propertiesID": child.get("propertiesID"),
			"propertiesName": child.get("propertiesName"),
			"propertiesType": child.get("propertiesType")
		}
		propertiesList.append(propertiesData)
	get_parent().get_parent()._acquire_global_values()

func _on_remove_properties_pressed():
		if propertiesContainer.get_child_count():
			var child = propertiesContainer.get_child(-1)
			propertiesContainer.remove_child(child)
			child.queue_free()
			propertiesIndexID -= 1
			_on_update_properties_list()

func _clean_list():
	if propertiesContainer.get_child_count():
		for child in propertiesContainer.get_children():
			propertiesContainer.remove_child(child)
			child.queue_free()
		propertiesIndexID = 0
		_on_update_properties_list()

func _load_global_values():
	var loadedPropertiesList = globalVariable.globalPropertiesList
	for properties in loadedPropertiesList:
		var loadedProperties = propertiesPanel.instantiate()
		loadedProperties.propertiesID = properties.propertiesID
		loadedProperties.propertiesName = properties.propertiesName
		loadedProperties.propertiesType = properties.propertiesType
		propertiesIndexID += 1
		propertiesContainer.add_child(loadedProperties)
	for child in propertiesContainer.get_children():
		var propertyData = {
			"propertiesID": child.get("propertiesID"),
			"propertiesName": child.get("propertiesName"),
			"propertiesType": child.get("propertiesType")
		}
		propertiesList.append(propertyData)
		
		
		
