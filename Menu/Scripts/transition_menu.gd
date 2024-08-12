extends Panel

#Transition Panel
var transitionPanel = load("res://Menu/transition_menu_row.tscn")
var transitionIndexID = 1
@onready var transitionContainer = $VBoxContainer/PanelContainer2/ScrollContainer/HBoxContainer/VBoxContainer
@export var transitionList = []

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_update_transition_list()

func _on_add_transition_pressed():
	var newRow = transitionPanel.instantiate()
	newRow.transitionID = transitionIndexID
	transitionIndexID += 1
	transitionContainer.add_child(newRow)
	_on_update_transition_list()

func _on_update_transition_list():
	transitionList = []
	for child in transitionContainer.get_children():
		var transitionData = {
			"transitionID": child.get("transitionID"),
			"transitionName": child.get("transitionName"),
			"transitionVariableBindingSet": child.get("transitionVariableBindingSet"),
			"transitionSelfTransitionMode": child.get("transitionSelfTransitionMode"),
			"transitionEventMode": child.get("transitionEventMode"),
			"transitionDuration": child.get("transitionDuration"),
			"transitionToGeneratorStartTimeFraction": child.get("transitionToGeneratorStartTimeFraction"),
			"transitionFlags": child.get("transitionFlags"),
			"transitionEndMode": child.get("transitionEndMode"),
			"transitionBlendCurve": child.get("transitionBlendCurve")
		}
		transitionList.append(transitionData)
	get_parent().get_parent()._acquire_global_values()


func _on_remove_transition_pressed():
	if transitionContainer.get_child_count():
		var child = transitionContainer.get_child(-1)
		transitionContainer.remove_child(child)
		child.queue_free()
		transitionIndexID -= 1
		_on_update_transition_list()

func _clean_list():
	if transitionContainer.get_child_count():
		for child in transitionContainer.get_children():
			transitionContainer.remove_child(child)
			child.queue_free()
		transitionIndexID = 1
		_on_update_transition_list()

func _load_global_values():
	var loadedTransitionList = globalVariable.globalTransitionList
	for transition in loadedTransitionList:
		var loadedTransition = transitionPanel.instantiate()
		loadedTransition.transitionID = transition.transitionID
		loadedTransition.transitionName = transition.transitionName
		loadedTransition.transitionVariableBindingSet = transition.transitionVariableBindingSet
		loadedTransition.transitionSelfTransitionMode = transition.transitionSelfTransitionMode
		loadedTransition.transitionEventMode = transition.transitionEventMode
		loadedTransition.transitionDuration = transition.transitionDuration
		loadedTransition.transitionToGeneratorStartTimeFraction = transition.transitionToGeneratorStartTimeFraction
		loadedTransition.transitionFlags = transition.transitionFlags
		loadedTransition.transitionEndMode = transition.transitionEndMode
		loadedTransition.transitionBlendCurve = transition.transitionBlendCurve
		transitionIndexID += 1
		transitionContainer.add_child(loadedTransition)
	for child in transitionContainer.get_children():
		var transitionData = {
			"transitionID": child.get("transitionID"),
			"transitionName": child.get("transitionName"),
			"transitionVariableBindingSet": child.get("transitionVariableBindingSet"),
			"transitionSelfTransitionMode": child.get("transitionSelfTransitionMode"),
			"transitionEventMode": child.get("transitionEventMode"),
			"transitionDuration": child.get("transitionDuration"),
			"transitionToGeneratorStartTimeFraction": child.get("transitionToGeneratorStartTimeFraction"),
			"transitionFlags": child.get("transitionFlags"),
			"transitionEndMode": child.get("transitionEndMode"),
			"transitionBlendCurve": child.get("transitionBlendCurve")
		}
		transitionList.append(transitionData)

