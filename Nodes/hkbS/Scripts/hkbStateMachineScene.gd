extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 5
var buttonToggled = false

#hkbStateMachine Values
@export var nodeName = "Root_SM"
@export var userData = 0
@export var startStateId = 0
@export var randomTransitionEventId = -1
@export var transitionToNextHigherStateEventId = -1
@export var transitionToNextLowerStateEventId = -1
@export var syncVariableIndex = -1
@export var wrapAroundStateId = false
@export var startStateMode = "START_STATE_MODE_DEFAULT"
@export var selfTransitionMode = "SELF_TRANSITION_MODE_NO_TRANSITION"
@export var eventId = -1
@export var payload = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	$Name.text = nodeName
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/userData/userDataButton.selected = userData
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startStateID/startStateIDSpinBox.value = startStateId
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/randomTransitionEventId/randomTransitionEventIdOptionButton._updateEvents()
	if randomTransitionEventId == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/randomTransitionEventId/randomTransitionEventIdOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/randomTransitionEventId/randomTransitionEventIdOptionButton.selected = randomTransitionEventId + 1
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/transitionToNextHigherStateEventId/transitionToNextHigherStateEventIdOptionButton._updateEvents()
	if transitionToNextHigherStateEventId == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/transitionToNextHigherStateEventId/transitionToNextHigherStateEventIdOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/transitionToNextHigherStateEventId/transitionToNextHigherStateEventIdOptionButton.selected = transitionToNextHigherStateEventId + 1
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/transitionToNextLowerStateEventId/transitionToNextLowerStateEventIdOptionButton._updateEvents()
	if transitionToNextLowerStateEventId == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/transitionToNextLowerStateEventId/transitionToNextLowerStateEventIdOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/transitionToNextLowerStateEventId/transitionToNextLowerStateEventIdOptionButton.selected = transitionToNextLowerStateEventId + 1
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/syncVariableIndex/syncVariableIndexOptionButton._updateVariables()
	if syncVariableIndex == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/syncVariableIndex/syncVariableIndexOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/syncVariableIndex/syncVariableIndexOptionButton.selected = syncVariableIndex + 1
	if wrapAroundStateId:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/wrapAroundStateId/wrapAroundStateIdButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/wrapAroundStateId/wrapAroundStateIdButton.selected = 0
	match startStateMode:
		"START_STATE_MODE_DEFAULT":
			$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startStateMode/startStateModeButton.selected = 0
		"START_STATE_MODE_SYNC":
			$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startStateMode/startStateModeButton.selected = 1
		"START_STATE_MODE_RANDOM":
			$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startStateMode/startStateModeButton.selected = 2
	match selfTransitionMode:
		"SELF_TRANSITION_MODE_NO_TRANSITION":
			$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/selfTransitionMode/selfTransitionModeButton.selected = 0
		"SELF_TRANSITION_MODE_TRANSITION_TO_START_STATE":
			$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/selfTransitionMode/selfTransitionModeButton.selected = 1
		"SELF_TRANSITION_MODE_FORCE_TRANSITION_TO_START_STATE":
			$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/selfTransitionMode/selfTransitionModeButton.selected = 2
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/id/eventToSendidOptionButton._updateEvents()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payload/eventToSendPayloadOptionButton._updatePayloads()
	if eventId == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/id/eventToSendidOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/id/eventToSendidOptionButton.selected = eventId + 1
	if payload == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payload/eventToSendPayloadOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payload/eventToSendPayloadOptionButton.selected = payload

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

func _on_node_id_spin_box_value_changed(value):
	nodeID = value
	self.title = 'hkbStateMachine - #' + str(nodeID)

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

# Sets the userData index of the State Machine.
func _on_user_data_button_item_selected(index):
	userData = index

# Sets the name of the State Machine.
func _on_name_text_changed(new_text):
	nodeName = new_text

# Update initialStateID value.
func _on_start_state_id_spin_box_value_changed(value):
	startStateId = int(value)

# Update randomTransitionEventId value.
func _on_random_transition_event_id_spin_box_value_changed(value):
	randomTransitionEventId = int(value)

# Update transitionToNextHigherStateEventId value.
func _on_transition_to_next_higher_state_event_id_spin_box_value_changed(value):
	transitionToNextHigherStateEventId = int(value)

# Update transitionToNextLowerStateEventId value.
func _on_transition_to_next_lower_state_event_id_spin_box_value_changed(value):
	transitionToNextLowerStateEventId = int(value)

# Update syncVariableIndex value.
func _on_sync_variable_index_spin_box_value_changed(value):
	syncVariableIndex = int(value)

func _on_event_to_send_payload_option_button_item_selected(index):
	if index == 0:
		payload = -1
	else:
		payload = index

func _on_wrap_around_state_id_button_item_selected(index):
	if index == 0:
		wrapAroundStateId = false
	else:
		wrapAroundStateId = true

func _on_start_state_mode_button_item_selected(index):
	match index:
		0:
			startStateMode = "START_STATE_MODE_DEFAULT"
		1:
			startStateMode = "START_STATE_MODE_SYNC"
		2:
			startStateMode = "START_STATE_MODE_RANDOM"

func _on_self_transition_mode_button_item_selected(index):
	match index:
		0:
			selfTransitionMode = "SELF_TRANSITION_MODE_NO_TRANSITION"
		1:
			selfTransitionMode = "SELF_TRANSITION_MODE_TRANSITION_TO_START_STATE"
		2:
			selfTransitionMode = "SELF_TRANSITION_MODE_FORCE_TRANSITION_TO_START_STATE"

func _on_event_to_sendid_option_button_item_selected(index):
	if index == 0:
		eventId = -1
	else:
		eventId = index - 1

func _on_random_transition_event_id_option_button_item_selected(index):
	if index == 0:
		randomTransitionEventId = -1
	else:
		randomTransitionEventId = index - 1

func _on_transition_to_next_higher_state_event_id_option_button_item_selected(index):
	if index == 0:
		transitionToNextHigherStateEventId = -1
	else:
		transitionToNextHigherStateEventId = index - 1

func _on_transition_to_next_lower_state_event_id_option_button_item_selected(index):
	if index == 0:
		transitionToNextLowerStateEventId = -1
	else:
		transitionToNextLowerStateEventId = index - 1

func _on_sync_variable_index_option_button_item_selected(index):
	if index == 0:
		syncVariableIndex = -1
	else:
		syncVariableIndex = index - 1

func _on_graph_data_button_pressed():
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/randomTransitionEventId/randomTransitionEventIdOptionButton._updateEvents()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/transitionToNextHigherStateEventId/transitionToNextHigherStateEventIdOptionButton._updateEvents()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/transitionToNextLowerStateEventId/transitionToNextLowerStateEventIdOptionButton._updateEvents()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/syncVariableIndex/syncVariableIndexOptionButton._updateVariables()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/id/eventToSendidOptionButton._updateEvents()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payload/eventToSendPayloadOptionButton._updatePayloads()
