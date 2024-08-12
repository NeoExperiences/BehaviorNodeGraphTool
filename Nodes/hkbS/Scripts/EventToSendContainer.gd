extends PanelContainer


# Event Variables
var eventID = 0
var payloadID = -1

func _on_id_spin_box_value_changed(value):
	eventID = value

func _on_event_to_send_payload_option_button_pressed():
	$VBoxContainer/payload/eventToSendPayloadOptionButton.updateEventPayloads()

func _on_event_to_send_payload_option_button_item_selected(index):
	payloadID = index
