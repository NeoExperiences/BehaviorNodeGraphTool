extends PanelContainer

# Trigger Clip Variables
var triggerIndex = 0
var localTime = "0.0"
var eventID = -1
var payloadID = -1
var relativeToEndOfClip = true
var acyclic = false
var isAnnotation = false


func _ready():
	$VBoxContainer/dataContainer/localTime/localTimeLine.text = localTime
	$VBoxContainer/dataContainer/relativeToEndOfClip/relativeToEndOfClipButton.selected = relativeToEndOfClip
	$VBoxContainer/dataContainer/acyclic/acyclicButton.selected = acyclic
	$VBoxContainer/dataContainer/isAnnotation/isAnnotationButton.selected = isAnnotation
	$VBoxContainer/dataContainer/id/idOptionButton._updateEvents()
	$VBoxContainer/dataContainer/payload/payloadOptionButton._updateEventPayloads()
	if eventID == -1:
		$VBoxContainer/dataContainer/id/idOptionButton.selected = 0
	else:
		$VBoxContainer/dataContainer/id/idOptionButton.selected = eventID + 1
	if payloadID == -1:
		$VBoxContainer/dataContainer/payload/payloadOptionButton.selected = 0
	else:
		$VBoxContainer/dataContainer/payload/payloadOptionButton.selected = payloadID

func _update_name():
	$VBoxContainer/PanelContainer/TriggerNameLabel.text = "Trigger #" + str(triggerIndex)

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
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()._on_update_trigger_array()

func _update_events():
	$VBoxContainer/dataContainer/id/idOptionButton._updateEvents()
	$VBoxContainer/dataContainer/payload/payloadOptionButton._updateEventPayloads()

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

func _on_show_button_pressed():
	if !$VBoxContainer/dataContainer.visible:
		$VBoxContainer/dataContainer.visible = 1
		$VBoxContainer/ShowButton.text = "Hide Data"
	else:
		$VBoxContainer/dataContainer.visible = 0
		$VBoxContainer/ShowButton.text = "Show Data"
	get_parent().get_parent().reset_size()
