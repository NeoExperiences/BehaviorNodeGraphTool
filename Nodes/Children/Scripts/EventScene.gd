extends PanelContainer

# Event Variables
var eventIndex = 0
var eventID = -1
var payloadID = -1

func _ready():
	#$VBoxContainer/id/eventsOptionButton.selected = eventID
	$VBoxContainer/id/idOptionButton._updateEvents()
	$VBoxContainer/payload/payloadOptionButton._updateEventPayloads()
	if eventID == -1:
		$VBoxContainer/id/idOptionButton.selected = 0
	else:
		$VBoxContainer/id/idOptionButton.selected = eventID + 1
	if payloadID == -1:
		$VBoxContainer/payload/payloadOptionButton.selected = 0
	else:
		$VBoxContainer/payload/payloadOptionButton.selected = payloadID

func _update_name():
	$VBoxContainer/PanelContainer/EventNameLabel.text = "Event #" + str(eventIndex)

func _on_id_spin_box_value_changed(value):
	eventID = value
	update_values()

func _on_id_option_button_item_selected(index):
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
	$VBoxContainer/id/idOptionButton._updateEvents()
	$VBoxContainer/payload/payloadOptionButton._updateEventPayloads()



