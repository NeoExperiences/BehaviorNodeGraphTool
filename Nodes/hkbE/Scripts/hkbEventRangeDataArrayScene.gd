extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 36
var buttonToggled = false

#hkbEventRangeDataArray Values
var rangepanel = load("res://Nodes/Children/RangeScene.tscn")
var rangeIndex = 0
var rangeArray = []
@onready var rangeContainer = $DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer

func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	if rangeArray:
		for rangeData in rangeArray:
			_load_ranges(rangeData.upperBound, rangeData.eventID, rangeData.payloadID, rangeData.eventMode)
	else:
		_on_add_range_pressed()
		_on_update_range_array()

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
	self.queue_free()

func _on_pin_button_toggled(toggled_on):
	buttonToggled = toggled_on
	$DataPopupPanel.popup_window = !buttonToggled

func _on_node_id_spin_box_value_changed(value):
	nodeID = value
	self.title = 'hkbEventRangeDataArray - #' + str(nodeID)

func _on_add_range_pressed():
	rangeIndex += 1
	var newRange = rangepanel.instantiate()
	newRange.rangeIndex = rangeIndex
	newRange._update_name()
	rangeContainer.add_child(newRange)
	_on_update_range_array()

func _on_remove_range_pressed():
	if rangeContainer.get_child_count() > 1:
		var deletedRange = rangeContainer.get_child(-1)
		rangeContainer.remove_child(deletedRange)
		deletedRange.queue_free()
		rangeIndex -= 1
		_on_update_range_array()
		rangeContainer.reset_size()

func _load_ranges(upperBound, eventID, payloadID, eventMode):
	rangeIndex += 1
	var newRange = rangepanel.instantiate()
	newRange.rangeIndex = rangeIndex
	newRange.upperBound = upperBound
	newRange.eventID = eventID
	newRange.payloadID = payloadID
	newRange.eventMode = eventMode
	newRange._update_name()
	rangeContainer.add_child(newRange)

# Update list of arrays
func _on_update_range_array():
	rangeArray = []
	for child in rangeContainer.get_children():
		if child.get_name() != "ButtonContainer":
			var rangeData = {
				"upperBound": child.get("upperBound"),
				"eventID": child.get("eventID"),
				"payloadID": child.get("payloadID"),
				"eventMode": child.get("eventMode"),
			}
			rangeArray.append(rangeData)


func _on_update_events_button_pressed():
	for child in rangeContainer.get_children():
		if child.get_name() != "ButtonContainer":
			child._update_events()






