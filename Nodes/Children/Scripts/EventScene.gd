extends PanelContainer

# Event Variables
var eventIndex = 0
var eventID = 0
var payloadID = -1

func _ready():
	#$VBoxContainer/id/eventsOptionButton.selected = eventID
	$VBoxContainer/id/idSpinBox.value = eventID
	$VBoxContainer/payload/payloadOptionButton.selected = payloadID

func _update_name():
	$VBoxContainer/PanelContainer/EventNameLabel.text = "Event #" + str(eventIndex)

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
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()._on_update_event_array()

func _update_events():
	$VBoxContainer/id/eventsOptionButton.updateEvents()
	$VBoxContainer/payload/payloadOptionButton.updateEventPayloads()
