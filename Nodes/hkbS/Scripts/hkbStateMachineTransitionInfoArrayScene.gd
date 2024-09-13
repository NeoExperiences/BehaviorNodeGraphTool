extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 7
@export var nodeColorID = 0
var buttonToggled = false

#hkbStateMachineTransitionInfoArray Values
var transitionpanel = load("res://Nodes/Children/TransitionScene.tscn")
var transitionIndex = 0
var transitionArray = []
@onready var transitionContainer = $DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer

func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	change_theme(nodeColorID)
	if transitionArray:
		for transition in transitionArray:
			_load_transitions(transition.eventId, transition.toStateId, transition.fromNestedStateId, transition.toNestedStateId, transition.priority, transition.flags, transition.transition, transition.triggerInterval, transition.initiateInterval)
	else:
		_on_add_transition_pressed()
		_on_update_transition_array()

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
			set_slot_color_left(0, Color(1,1,1,1))
			set_slot_color_right(0, Color(1,1,1,1))
			set_slot_color_right(1, Color(1,1,1,1))
			set_slot_color_right(2, Color(1,1,1,1))
			set_slot_color_right(3, Color(1,1,1,1))
			set_slot_color_right(4, Color(1,1,1,1))
			set_slot_color_right(5, Color(1,1,1,1))
		1:
			self.set_theme(globalVariable.redTheme)
			set_slot_color_left(0, Color(1,0.4,0.35,1))
			set_slot_color_right(0, Color(1,0.4,0.35,1))
			set_slot_color_right(1, Color(1,0.4,0.35,1))
			set_slot_color_right(2, Color(1,0.4,0.35,1))
			set_slot_color_right(3, Color(1,0.4,0.35,1))
			set_slot_color_right(4, Color(1,0.4,0.35,1))
			set_slot_color_right(5, Color(1,0.4,0.35,1))
		2:
			self.set_theme(globalVariable.orangeTheme)
			set_slot_color_left(0, Color(0.9,0.55,0.3,1))
			set_slot_color_right(1, Color(0.9,0.55,0.3,1))
			set_slot_color_right(2, Color(0.9,0.55,0.3,1))
			set_slot_color_right(3, Color(0.9,0.55,0.3,1))
			set_slot_color_right(4, Color(0.9,0.55,0.3,1))
			set_slot_color_right(5, Color(0.9,0.55,0.3,1))
			set_slot_color_right(6, Color(0.9,0.55,0.3,1))
		3:
			self.set_theme(globalVariable.yellowTheme)
			set_slot_color_left(0, Color(1,0.9,0.4,1))
			set_slot_color_right(1, Color(1,0.9,0.4,1))
			set_slot_color_right(2, Color(1,0.9,0.4,1))
			set_slot_color_right(3, Color(1,0.9,0.4,1))
			set_slot_color_right(4, Color(1,0.9,0.4,1))
			set_slot_color_right(5, Color(1,0.9,0.4,1))
			set_slot_color_right(6, Color(1,0.9,0.4,1))
		4:
			self.set_theme(globalVariable.brownTheme)
			set_slot_color_left(0, Color(0.7,0.6,0.5,1))
			set_slot_color_right(1, Color(0.7,0.6,0.5,1))
			set_slot_color_right(2, Color(0.7,0.6,0.5,1))
			set_slot_color_right(3, Color(0.7,0.6,0.5,1))
			set_slot_color_right(4, Color(0.7,0.6,0.5,1))
			set_slot_color_right(5, Color(0.7,0.6,0.5,1))
			set_slot_color_right(6, Color(0.7,0.6,0.5,1))
		5:
			self.set_theme(globalVariable.greenTheme)
			set_slot_color_left(0, Color(0.7,0.8,0.4,1))
			set_slot_color_right(1, Color(0.7,0.8,0.4,1))
			set_slot_color_right(2, Color(0.7,0.8,0.4,1))
			set_slot_color_right(3, Color(0.7,0.8,0.4,1))
			set_slot_color_right(4, Color(0.7,0.8,0.4,1))
			set_slot_color_right(5, Color(0.7,0.8,0.4,1))
			set_slot_color_right(6, Color(0.7,0.8,0.4,1))
		6:
			self.set_theme(globalVariable.emeraldTheme)
			set_slot_color_left(0, Color(0.5,0.8,0.5,1))
			set_slot_color_right(1, Color(0.5,0.8,0.5,1))
			set_slot_color_right(2, Color(0.5,0.8,0.5,1))
			set_slot_color_right(3, Color(0.5,0.8,0.5,1))
			set_slot_color_right(4, Color(0.5,0.8,0.5,1))
			set_slot_color_right(5, Color(0.5,0.8,0.5,1))
			set_slot_color_right(6, Color(0.5,0.8,0.5,1))
		7:
			self.set_theme(globalVariable.ceruleanTheme)
			set_slot_color_left(0, Color(0.4,0.7,0.7,1))
			set_slot_color_right(1, Color(0.4,0.7,0.7,1))
			set_slot_color_right(2, Color(0.4,0.7,0.7,1))
			set_slot_color_right(3, Color(0.4,0.7,0.7,1))
			set_slot_color_right(4, Color(0.4,0.7,0.7,1))
			set_slot_color_right(5, Color(0.4,0.7,0.7,1))
			set_slot_color_right(6, Color(0.4,0.7,0.7,1))
		8:
			self.set_theme(globalVariable.blueTheme)
			set_slot_color_left(0, Color(0.45,0.65,0.75,1))
			set_slot_color_right(1, Color(0.45,0.65,0.75,1))
			set_slot_color_right(2, Color(0.45,0.65,0.75,1))
			set_slot_color_right(3, Color(0.45,0.65,0.75,1))
			set_slot_color_right(4, Color(0.45,0.65,0.75,1))
			set_slot_color_right(5, Color(0.45,0.65,0.75,1))
			set_slot_color_right(6, Color(0.45,0.65,0.75,1))
		9:
			self.set_theme(globalVariable.deepBlueTheme)
			set_slot_color_left(0, Color(0.3,0.3,0.7,1))
			set_slot_color_right(1, Color(0.3,0.3,0.7,1))
			set_slot_color_right(2, Color(0.3,0.3,0.7,1))
			set_slot_color_right(3, Color(0.3,0.3,0.7,1))
			set_slot_color_right(4, Color(0.3,0.3,0.7,1))
			set_slot_color_right(5, Color(0.3,0.3,0.7,1))
			set_slot_color_right(6, Color(0.3,0.3,0.7,1))
		10:
			self.set_theme(globalVariable.purpleTheme)
			set_slot_color_left(0, Color(0.6,0.45,0.7,1))
			set_slot_color_right(1, Color(0.6,0.45,0.7,1))
			set_slot_color_right(2, Color(0.6,0.45,0.7,1))
			set_slot_color_right(3, Color(0.6,0.45,0.7,1))
			set_slot_color_right(4, Color(0.6,0.45,0.7,1))
			set_slot_color_right(5, Color(0.6,0.45,0.7,1))
			set_slot_color_right(6, Color(0.6,0.45,0.7,1))
		11:
			self.set_theme(globalVariable.eggplantTheme)
			set_slot_color_left(0, Color(0.7,0.4,0.6,1))
			set_slot_color_right(1, Color(0.7,0.4,0.6,1))
			set_slot_color_right(2, Color(0.7,0.4,0.6,1))
			set_slot_color_right(3, Color(0.7,0.4,0.6,1))
			set_slot_color_right(4, Color(0.7,0.4,0.6,1))
			set_slot_color_right(5, Color(0.7,0.4,0.6,1))
			set_slot_color_right(6, Color(0.7,0.4,0.6,1))

func _on_add_transition_pressed():
	transitionIndex += 1
	var newTransition = transitionpanel.instantiate()
	newTransition.transitionIndex = transitionIndex
	newTransition._update_name()
	transitionContainer.add_child(newTransition)
	_on_update_transition_array()

func _load_transitions(eventId, toStateId, fromNestedStateId, toNestedStateId, priority, flags, transition, triggerInterval, initiateInterval):
	transitionIndex += 1
	var newTransition = transitionpanel.instantiate()
	newTransition.transitionIndex = transitionIndex
	newTransition.eventId = eventId
	newTransition.toStateId = toStateId
	newTransition.fromNestedStateId = fromNestedStateId
	newTransition.toNestedStateId = toNestedStateId
	newTransition.priority = priority
	newTransition.flags = flags
	newTransition.transition = transition
	newTransition.triggerInterval = triggerInterval
	newTransition.initiateInterval = initiateInterval
	newTransition._update_name()
	transitionContainer.add_child(newTransition)

# Update list of arrays
func _on_update_transition_array():
	transitionArray = []
	for child in transitionContainer.get_children():
		if child.get_name() != "ButtonContainer":
			var transitionData = {
				"eventId": child.get("eventId"),
				"toStateId": child.get("toStateId"),
				"fromNestedStateId": child.get("fromNestedStateId"),
				"toNestedStateId": child.get("toNestedStateId"),
				"priority": child.get("priority"),
				"flags": child.get("flags"),
				"transition": child.get("transition"),
				"triggerInterval": child.get("triggerInterval"),
				"initiateInterval": child.get("initiateInterval")
			}
			transitionArray.append(transitionData)

func _on_update_transitions_button_pressed():
	for child in transitionContainer.get_children():
		if child.get_name() != "ButtonContainer":
			child._update_transitions()

func _on_remove_transition_pressed():
	if transitionContainer.get_child_count() > 1:
		var deletedTransition = transitionContainer.get_child(-1)
		transitionContainer.remove_child(deletedTransition)
		deletedTransition.queue_free()
		transitionIndex -= 1
		_on_update_transition_array()

func _on_node_id_spin_box_value_changed(value):
	nodeID = value
	self.title = 'hkbStateMachineTransitionInfoArray - #' + str(nodeID)






