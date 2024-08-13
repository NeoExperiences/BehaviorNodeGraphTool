extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 8
var buttonToggled = false

#hkbStateMachineEventPropertyArray Values
var eventpanel = load("res://Nodes/Children/EventScene.tscn")
var eventIndex = 0
var eventsArray = []
@onready var eventContainer = $DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer

func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	if eventsArray:
		for event in eventsArray:
			_load_events(event.eventID, event.payloadID)
	else:
		_on_add_event_pressed()
		_on_update_event_array()
	

func _on_gui_input(event):
	if event is InputEventMouseButton and event.double_click:
		show_popup()

func show_popup():
	$DataPopupPanel.popup()
	self.draggable = false

func _on_popup_panel_popup_hide():
	self.draggable = true
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

func _on_add_event_pressed():
	eventIndex += 1
	var newEvent = eventpanel.instantiate()
	newEvent.eventIndex = eventIndex
	newEvent._update_name()
	eventContainer.add_child(newEvent)
	_on_update_event_array()

func _load_events(eventId, payload):
	eventIndex += 1
	var newEvent = eventpanel.instantiate()
	newEvent.eventIndex = eventIndex
	newEvent.eventID = eventId
	newEvent.payloadID = payload
	newEvent._update_name()
	eventContainer.add_child(newEvent)

# Update list of arrays
func _on_update_event_array():
	eventsArray = []
	for child in eventContainer.get_children():
		if child.get_name() != "ButtonContainer":
			var transitionData = {
				"eventID": child.get("eventID"),
				"payloadID": child.get("payloadID"),
			}
			eventsArray.append(transitionData)


func _on_update_events_button_pressed():
	for child in eventContainer.get_children():
		if child.get_name() != "ButtonContainer":
			child._update_events()


func _on_remove_event_pressed():
	if eventContainer.get_child_count() > 1:
		var deletedEvent = eventContainer.get_child(-1)
		eventContainer.remove_child(deletedEvent)
		deletedEvent.queue_free()
		eventIndex -= 1
		_on_update_event_array()
		eventContainer.reset_size()


func _on_node_id_spin_box_value_changed(value):
	nodeID = value
	self.title = 'hkbStateMachineEventPropertyArray - #' + str(nodeID)
