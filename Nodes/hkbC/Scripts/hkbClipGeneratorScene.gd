extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 25
var buttonToggled = false

#hkbClipGenerator Values
@export var nodeName = "ClipAnimation"
@export var userData = 0
@export var enable = true
@export var animationName = ""
@export var cropStartAmountLocalTime = "0.0"
@export var cropEndAmountLocalTime = "0.0"
@export var startTime = "0.0"
@export var playbackSpeed = "1.0"
@export var enforcedDuration = "0.0"
@export var userControlledTimeFraction = "0.0"
@export var mode = 0
@export var flagsIndex = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	$Name.text = nodeName
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/userData/userDataButton.selected = userData
	if enable:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enable/enableButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enable/enableButton.selected = 0
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/animationName/animationNameLine.text = animationName
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/cropStartAmountLocalTime/cropStartAmountLocalTimeLine.text = cropStartAmountLocalTime
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/cropEndAmountLocalTime/cropEndAmountLocalTimeLine.text = cropEndAmountLocalTime
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startTime/startTimeLine.text = startTime
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/playbackSpeed/playbackSpeedLine.text = playbackSpeed
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enforcedDuration/enforcedDurationLine.text = enforcedDuration
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/userControlledTimeFraction/userControlledTimeFractionLine.text = userControlledTimeFraction
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/mode/modeButton.selected = mode
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/flagsIndex/flagsIndexSpinBox.value = flagsIndex
	

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
	self.title = 'hkbClipGenerator - #' + str(nodeID)

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

func _on_name_text_changed(new_text):
	nodeName = new_text

func _on_user_data_button_item_selected(index):
	userData = index

func _on_enable_button_item_selected(index):
	if index == 1:
		enable = true
	else:
		enable = false

func _on_animation_name_line_text_changed(new_text):
	animationName = new_text

func _on_crop_start_amount_local_time_line_text_changed(new_text):
	cropStartAmountLocalTime = new_text

func _on_crop_end_amount_local_time_line_text_changed(new_text):
	cropEndAmountLocalTime = new_text

func _on_start_time_line_text_changed(new_text):
	startTime = new_text

func _on_playback_speed_line_text_changed(new_text):
	playbackSpeed = new_text

func _on_enforced_duration_line_text_changed(new_text):
	enforcedDuration = new_text

func _on_user_controlled_time_fraction_line_text_changed(new_text):
	userControlledTimeFraction = new_text

func _on_mode_button_item_selected(index):
	mode = index

func _on_flags_index_spin_box_value_changed(value):
	flagsIndex = value
