extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 26
@export var nodeColorID = 0
var buttonToggled = false

#hkbClipTriggerArray Values
var triggerpanel = load("res://Nodes/Children/TriggerScene.tscn")
var triggerIndex = 0
var triggersArray = []
@onready var triggerContainer = $DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer

func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	change_theme(nodeColorID)
	if triggersArray:
		for loadedTrigger in triggersArray:
			_load_triggers(loadedTrigger)
	else:
		_on_add_trigger_pressed()
		_on_update_trigger_array()
	

func _on_gui_input(event):
	if event is InputEventMouseButton and event.double_click:
		show_popup()

func show_popup():
	$DataPopupPanel.popup()
	self.draggable = false

func _on_popup_panel_popup_hide():
	self.draggable = true
	self.selected = false
	$DataPopupPanel/VBoxContainer/BaseNode/DeleteButton.show()
	$DataPopupPanel/VBoxContainer/BaseNode/ConfirmDeleteButton.hide()

func _on_edit_button_pressed():
	show_popup()

func _on_delete_button_pressed():
	$DataPopupPanel/VBoxContainer/BaseNode/DeleteButton.hide()
	$DataPopupPanel/VBoxContainer/BaseNode/ConfirmDeleteButton.show()

func _on_confirm_delete_button_pressed():
	var parentGraph = get_parent()
	parentGraph.remove_child(self)
	parentGraph.get_parent().selected_nodes = []
	self.queue_free()

func _on_pin_button_toggled(toggled_on):
	buttonToggled = toggled_on
	$DataPopupPanel/VBoxContainer/BaseNode/PinButton/PinIcon.visible = !buttonToggled
	$DataPopupPanel/VBoxContainer/BaseNode/PinButton/UnpinIcon.visible = buttonToggled
	$DataPopupPanel.popup_window = !buttonToggled

func _on_paint_button_pressed():
	nodeColorID += 1
	if nodeColorID > 11:
		nodeColorID = 0
	change_theme(nodeColorID)

func change_theme(index):
	match index:
		0:
			self.set_theme(globalVariable.defaultTheme)
		1:
			self.set_theme(globalVariable.redTheme)
		2:
			self.set_theme(globalVariable.orangeTheme)
		3:
			self.set_theme(globalVariable.yellowTheme)
		4:
			self.set_theme(globalVariable.brownTheme)
		5:
			self.set_theme(globalVariable.greenTheme)
		6:
			self.set_theme(globalVariable.emeraldTheme)
		7:
			self.set_theme(globalVariable.ceruleanTheme)
		8:
			self.set_theme(globalVariable.blueTheme)
		9:
			self.set_theme(globalVariable.deepBlueTheme)
		10:
			self.set_theme(globalVariable.purpleTheme)
		11:
			self.set_theme(globalVariable.eggplantTheme)

func _on_add_trigger_pressed():
	triggerIndex += 1
	var newTrigger = triggerpanel.instantiate()
	newTrigger.triggerIndex = triggerIndex
	newTrigger._update_name()
	triggerContainer.add_child(newTrigger)
	_on_update_trigger_array()

func _load_triggers(loadedTrigger):
	triggerIndex += 1
	var newTrigger = triggerpanel.instantiate()
	newTrigger.triggerIndex = triggerIndex
	newTrigger.localTime = loadedTrigger.localTime
	newTrigger.eventID = loadedTrigger.eventID
	newTrigger.payloadID = loadedTrigger.payloadID
	newTrigger.relativeToEndOfClip = loadedTrigger.relativeToEndOfClip
	newTrigger.acyclic = loadedTrigger.acyclic
	newTrigger.isAnnotation = loadedTrigger.isAnnotation
	newTrigger._update_name()
	triggerContainer.add_child(newTrigger)

# Update list of arrays
func _on_update_trigger_array():
	triggersArray = []
	for child in triggerContainer.get_children():
		if child.get_name() != "ButtonContainer":
			var transitionData = {
				"localTime": child.get("localTime"),
				"relativeToEndOfClip": child.get("relativeToEndOfClip"),
				"acyclic": child.get("acyclic"),
				"isAnnotation": child.get("isAnnotation"),
				"eventID": child.get("eventID"),
				"payloadID": child.get("payloadID"),
			}
			triggersArray.append(transitionData)


func _on_update_events_button_pressed():
	for child in triggerContainer.get_children():
		if child.get_name() != "ButtonContainer":
			child._update_events()

func _on_remove_trigger_pressed():
	if triggerContainer.get_child_count() > 1:
		var deletedTrigger = triggerContainer.get_child(-1)
		triggerContainer.remove_child(deletedTrigger)
		deletedTrigger.queue_free()
		triggerIndex -= 1
		_on_update_trigger_array()
		triggerContainer.reset_size()

func _on_node_id_spin_box_value_changed(value):
	nodeID = value
	self.title = 'hkbClipTriggerArray - #' + str(nodeID)




