extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 39
var buttonToggled = false

#BSCyclicBlendTransitionGenerator Values
@export var nodeName = "CyclicBlendTransitionGenerator"
@export var userData = 0
@export var fTransitionDuration = "0.20000000298023224"
@export var EventToFreezeBlendValueID = -1
@export var EventToFreezeBlendValuePayload = -1
@export var EventToCrossBlendID = -1
@export var EventToCrossBlendPayload = -1
@export var TransitionOutEventID = -1
@export var TransitionOutEventPayload = -1
@export var TransitionInEventID = -1
@export var TransitionInEventPayload = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	$Name.text = nodeName
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/userData/userDataButton.selected = userData
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idFreezeBlend/FreezeBlendidOptionButton._updateEvents()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idEventToCrossBlend/EventToCrossBlendidOptionButton._updateEvents()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idTransitionOutEvent/TransitionOutEventidOptionButton._updateEvents()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idTransitionInEvent/TransitionInEventEventidOptionButton._updateEvents()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payloadFreezeBlend/FreezeBlendPayloadOptionButton._updatePayloads()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payloadEventToCrossBlend/EventToCrossBlendPayloadOptionButton._updatePayloads()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payloadTransitionOutEvent/TransitionOutEventPayloadOptionButton._updatePayloads()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payloadTransitionInEvent/TransitionInEventEventPayloadOptionButton._updatePayloads()
	
	if EventToFreezeBlendValueID == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idFreezeBlend/FreezeBlendidOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idFreezeBlend/FreezeBlendidOptionButton.selected = EventToFreezeBlendValueID + 1
	if EventToCrossBlendID == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idEventToCrossBlend/EventToCrossBlendidOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idEventToCrossBlend/EventToCrossBlendidOptionButton.selected = EventToCrossBlendID + 1
	if TransitionOutEventID == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idTransitionOutEvent/TransitionOutEventidOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idTransitionOutEvent/TransitionOutEventidOptionButton.selected = TransitionOutEventID + 1
	if TransitionInEventID == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idTransitionInEvent/TransitionInEventEventidOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idTransitionInEvent/TransitionInEventEventidOptionButton.selected = TransitionInEventID + 1
	
	
	if EventToFreezeBlendValuePayload == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payloadFreezeBlend/FreezeBlendPayloadOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payloadFreezeBlend/FreezeBlendPayloadOptionButton.selected = EventToFreezeBlendValuePayload
	if EventToCrossBlendPayload == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payloadEventToCrossBlend/EventToCrossBlendPayloadOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payloadEventToCrossBlend/EventToCrossBlendPayloadOptionButton.selected = EventToCrossBlendPayload
	if TransitionOutEventPayload == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payloadTransitionOutEvent/TransitionOutEventPayloadOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payloadTransitionOutEvent/TransitionOutEventPayloadOptionButton.selected = TransitionOutEventPayload
	if TransitionInEventPayload == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payloadTransitionInEvent/TransitionInEventEventPayloadOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payloadTransitionInEvent/TransitionInEventEventPayloadOptionButton.selected = TransitionInEventPayload

	
	
	#$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idFreezeBlend/FreezeBlendidSpinBox.value = EventToFreezeBlendValueID
	#$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idEventToCrossBlend/EventToCrossBlendidSpinBox.value = EventToCrossBlendID
	#$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idTransitionOutEvent/TransitionOutEventidSpinBox.value = TransitionOutEventID
	#$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idTransitionInEvent/TransitionInEventEventidSpinBox.value = TransitionInEventID

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

func _on_node_id_spin_box_value_changed(value):
	nodeID = value
	self.title = 'BSCyclicBlendTransitionGenerator - #' + str(nodeID)

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

func _on_update_events_button_pressed():
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idFreezeBlend/FreezeBlendidOptionButton._updateEvents()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idEventToCrossBlend/EventToCrossBlendidOptionButton._updateEvents()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idTransitionOutEvent/TransitionOutEventidOptionButton._updateEvents()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/idTransitionInEvent/TransitionInEventEventidOptionButton._updateEvents()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payloadFreezeBlend/FreezeBlendPayloadOptionButton._updatePayloads()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payloadEventToCrossBlend/EventToCrossBlendPayloadOptionButton._updatePayloads()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payloadTransitionOutEvent/TransitionOutEventPayloadOptionButton._updatePayloads()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/payloadTransitionInEvent/TransitionInEventEventPayloadOptionButton._updatePayloads()

func _on_f_transition_duration_line_text_changed(new_text):
	fTransitionDuration = new_text

func _on_freeze_blendid_spin_box_value_changed(value):
	EventToFreezeBlendValueID = value

func _on_freeze_blend_payload_option_button_item_selected(index):
	if index == 0:
		EventToFreezeBlendValuePayload = -1
	else:
		EventToFreezeBlendValuePayload = index

func _on_event_to_cross_blendid_spin_box_value_changed(value):
	EventToCrossBlendID = value

func _on_event_to_cross_blend_payload_option_button_item_selected(index):
	if index == 0:
		EventToCrossBlendPayload = -1
	else:
		EventToCrossBlendPayload = index

func _on_transition_out_eventid_spin_box_value_changed(value):
	TransitionOutEventID = value

func _on_transition_out_event_payload_option_button_item_selected(index):
	if index == 0:
		TransitionOutEventPayload = -1
	else:
		TransitionOutEventPayload = index

func _on_transition_in_event_eventid_spin_box_value_changed(value):
	TransitionInEventID = value

func _on_transition_in_event_event_payload_option_button_item_selected(index):
	if index == 0:
		TransitionInEventPayload = -1
	else:
		TransitionInEventPayload = index

func _on_freeze_blendid_option_button_item_selected(index):
	if index == 0:
		EventToFreezeBlendValueID = -1
	else:
		EventToFreezeBlendValueID = index - 1

func _on_event_to_cross_blendid_option_button_item_selected(index):
	if index == 0:
		EventToCrossBlendID = -1
	else:
		EventToCrossBlendID = index - 1

func _on_transition_out_eventid_option_button_item_selected(index):
	if index == 0:
		TransitionOutEventID = -1
	else:
		TransitionOutEventID = index - 1

func _on_transition_in_event_eventid_option_button_item_selected(index):
	if index == 0:
		TransitionInEventID = -1
	else:
		TransitionInEventID = index - 1
