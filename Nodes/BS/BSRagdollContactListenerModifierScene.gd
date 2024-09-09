extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 38
var buttonToggled = false

#BSRagdollContactListenerModifier Values
@export var nodeName = "RagdollContactListenerModifier"
@export var userData = 0
@export var enable = true
@export var eventId = -1
@export var payload = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	$Name.text = nodeName
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/userData/userDataButton.selected = userData
	if enable:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enable/enableButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enable/enableButton.selected = 0
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/EventToSend/VBoxContainer/id/idOptionButton._updateEvents()
	if eventId == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/EventToSend/VBoxContainer/id/idOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/EventToSend/VBoxContainer/id/idOptionButton.selected = eventId + 1
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/EventToSend/VBoxContainer/payload/eventToSendPayloadOptionButton._updatePayloads()
	if payload == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/EventToSend/VBoxContainer/payload/eventToSendPayloadOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/EventToSend/VBoxContainer/payload/eventToSendPayloadOptionButton.selected = payload

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
	self.title = 'BSRagdollContactListenerModifier - #' + str(nodeID)

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

func _on_update_payload_button_pressed():
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/EventToSend/VBoxContainer/id/idOptionButton._updateEvents()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/EventToSend/VBoxContainer/payload/eventToSendPayloadOptionButton._updatePayloads()


func _on_id_option_button_item_selected(index):
	if index == 0:
		eventId = -1
	else:
		eventId = index - 1

func _on_event_to_send_payload_option_button_item_selected(index):
	if index == 0:
		payload = -1
	else:
		payload = index

func _on_show_event_to_send_button_pressed():
	if !$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/EventToSend.visible:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/EventToSend.visible = 1
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ShowEventToSendButton.text = "Hide Event To Send on Change"
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/EventToSend.visible = 0
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ShowEventToSendButton.text = "Show Event To Send on Change"
	$DataPopupPanel.reset_size()

func _on_enable_button_item_selected(index):
	if index == 1:
		enable = true
	else:
		enable = false