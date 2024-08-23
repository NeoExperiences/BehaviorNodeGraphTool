extends PanelContainer

# Range Variables
var rangeIndex = 0
var upperBound = "1.0"
var eventID = 0
var payloadID = -1
var eventMode = 0

func _ready():
	#$VBoxContainer/id/eventsOptionButton.selected = eventID
	$VBoxContainer/dataContainer/upperBound/upperBoundLineEdit.text = upperBound
	$VBoxContainer/dataContainer/id/idSpinBox.value = eventID
	if eventID == -1:
		$VBoxContainer/dataContainer/eventId/eventIdOptionButton.selected = 0
	else:
		$VBoxContainer/dataContainer/eventId/eventIdOptionButton.selected = eventID + 1
	$VBoxContainer/dataContainer/payload/payloadOptionButton.selected = payloadID
	$VBoxContainer/dataContainer/eventMode/eventModeButton.selected = eventMode

func _update_name():
	$VBoxContainer/PanelContainer/RangeNameLabel.text = "Event Data #" + str(rangeIndex)

func _on_id_spin_box_value_changed(value):
	eventID = value
	update_values()

func _on_events_option_button_item_selected(index):
	if index == 0:
		eventID = -1
	else:
		eventID = index - 1
	update_values()


func _on_payload_option_button_item_selected(index):
	if index == 0:
		payloadID = -1
	else:
		payloadID = index
	update_values()

func update_values():
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()._on_update_range_array()

func _update_events():
	$VBoxContainer/dataContainer/id/eventsOptionButton.updateEvents()
	$VBoxContainer/dataContainer/payload/payloadOptionButton.updateEventPayloads()

func _on_upper_bound_line_edit_text_changed(new_text):
	upperBound = new_text
	update_values()

func _on_event_mode_button_item_selected(index):
	eventMode = index
	update_values()


func _on_show_button_pressed():
	if !$VBoxContainer/dataContainer.visible:
		$VBoxContainer/dataContainer.visible = 1
		$VBoxContainer/ShowButton.text = "Hide Data"
	else:
		$VBoxContainer/dataContainer.visible = 0
		$VBoxContainer/ShowButton.text = "Show Data"
	get_parent().get_parent().reset_size()


func _on_event_id_option_button_item_selected(index):
	if index == 0:
		eventID = -1
	else:
		eventID = index - 1
	update_values()
