extends PanelContainer

# Trigger Clip Variables
var triggerIndex = 0
var localTime = "0.0"
var eventID = 0
var payloadID = -1
var relativeToEndOfClip = true
var acyclic = false
var isAnnotation = false


func _ready():
	$VBoxContainer/localTime/localTimeLine.text = localTime
	#$VBoxContainer/id/eventsOptionButton.selected = eventID
	$VBoxContainer/id/idSpinBox.value = eventID
	$VBoxContainer/payload/payloadOptionButton.selected = payloadID
	$VBoxContainer/relativeToEndOfClip/relativeToEndOfClipButton.selected = relativeToEndOfClip
	$VBoxContainer/acyclic/acyclicButton.selected = acyclic
	$VBoxContainer/isAnnotation/isAnnotationButton.selected = isAnnotation

func _update_name():
	$VBoxContainer/PanelContainer/TriggerNameLabel.text = "Trigger #" + str(triggerIndex)

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
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()._on_update_trigger_array()

func _update_events():
	$VBoxContainer/id/eventsOptionButton.updateEvents()
	$VBoxContainer/payload/payloadOptionButton.updateEventPayloads()

func _on_local_time_line_text_changed(new_text):
	localTime = new_text
	update_values()


func _on_relative_to_end_of_clip_button_item_selected(index):
	if index == 1:
		relativeToEndOfClip = true
	else:
		relativeToEndOfClip = false
	update_values()

func _on_acyclic_button_item_selected(index):
	if index == 1:
		acyclic = true
	else:
		acyclic = false
	update_values()

func _on_is_annotation_button_item_selected(index):
	if index == 1:
		isAnnotation = true
	else:
		isAnnotation = false
	update_values()
