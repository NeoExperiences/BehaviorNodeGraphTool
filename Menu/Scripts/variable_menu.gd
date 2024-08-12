extends Panel

#Variable Panel
var variablePanel = load("res://Menu/variable_menu_row.tscn")
var variableIndexID = 0
@export var variableList = []
@onready var variableContainer = $VBoxContainer/PanelContainer2/ScrollContainer/HBoxContainer/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_update_variable_list()

func _on_add_transition_pressed():
	var newRow = variablePanel.instantiate()
	newRow.variableID = variableIndexID
	variableIndexID += 1
	variableContainer.add_child(newRow)
	_on_update_variable_list()

func _on_update_variable_list():
	variableList = []
	for child in variableContainer.get_children():
		var variableData = {
			"variableID": child.get("variableID"),
			"variableName": child.get("variableName"),
			"variableType": child.get("variableType"),
			"variableValue": child.get("variableValue"),
			"variableMinValue": child.get("variableMinValue"),
			"variableMaxValue": child.get("variableMaxValue"),
			"variableQuadValues": child.get("variableQuadValues")
		}
		variableList.append(variableData)
	get_parent().get_parent()._acquire_global_values()


func _on_remove_transition_pressed():
	if variableContainer.get_child_count():
		var child = variableContainer.get_child(-1)
		variableContainer.remove_child(child)
		child.queue_free()
		variableIndexID -= 1
		_on_update_variable_list()


func _clean_list():
	if variableContainer.get_child_count():
		for child in variableContainer.get_children():
			variableContainer.remove_child(child)
			child.queue_free()
		variableIndexID = 0
		_on_update_variable_list()

func _load_global_values():
	var loadedVariableList = globalVariable.globalVariableList
	for variable in loadedVariableList:
		var loadedVariable = variablePanel.instantiate()
		loadedVariable.variableID = variable.variableID
		loadedVariable.variableName = variable.variableName
		loadedVariable.variableType = variable.variableType
		loadedVariable.variableValue = variable.variableValue
		loadedVariable.variableMinValue = variable.variableMinValue
		loadedVariable.variableMaxValue = variable.variableMaxValue
		loadedVariable.variableQuadValues = variable.variableQuadValues
		variableIndexID += 1
		variableContainer.add_child(loadedVariable)
	for child in variableContainer.get_children():
		var variableData = {
			"variableID": child.get("variableID"),
			"variableName": child.get("variableName"),
			"variableType": child.get("variableType"),
			"variableValue": child.get("variableValue"),
			"variableMinValue": child.get("variableMinValue"),
			"variableMaxValue": child.get("variableMaxValue"),
			"variableQuadValues": child.get("variableQuadValues")
		}
		variableList.append(variableData)
