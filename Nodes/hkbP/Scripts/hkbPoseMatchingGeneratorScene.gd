extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 22
var buttonToggled = false

#hkbPoseMatchingGenerator Values
@export var nodeName = "PoseMatchingGenerator"
@export var userData = 0
@export var enable = true
@export var blendParameter = "0.0"
@export var blendSpeed = "1.0"
@export var minSpeedToSwitch = "0.20000000298023224"
@export var startPlayingEventId = 0
@export var startMatchingEventId = 0
@export var rootBoneIndex = 0
@export var otherBoneIndex = 0
@export var anotherBoneIndex = 0
@export var pelvisIndex = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	$Name.text = nodeName
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/userData/userDataButton.selected = userData
	if enable:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enable/enableButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enable/enableButton.selected = 0
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/blendParameter/blendParameterLine.text = blendParameter
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/blendSpeed/blendSpeedLine.text = blendSpeed
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/minSpeedToSwitch/minSpeedToSwitchLine.text = minSpeedToSwitch
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startPlayingEventId/startPlayingEventIdSpinBox.value = startPlayingEventId
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startMatchingEventId/startMatchingEventIdSpinBox.value = startMatchingEventId
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/rootBoneIndex/rootBoneIndexSpinBox.value = rootBoneIndex
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/otherBoneIndex/otherBoneIndexSpinBox.value = otherBoneIndex
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/anotherBoneIndex/anotherBoneIndexSpinBox.value = anotherBoneIndex
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/pelvisIndex/pelvisIndexSpinBox.value = pelvisIndex
	

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
	self.title = 'hkbPoseMatchingGenerator - #' + str(nodeID)

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

func _on_blend_parameter_line_text_changed(new_text):
	blendParameter = new_text


func _on_blend_speed_line_text_changed(new_text):
	blendSpeed = new_text


func _on_min_speed_to_switch_line_text_changed(new_text):
	minSpeedToSwitch = new_text


func _on_start_playing_event_id_spin_box_value_changed(value):
	startPlayingEventId = value


func _on_start_matching_event_id_spin_box_value_changed(value):
	startMatchingEventId = value


func _on_root_bone_index_spin_box_value_changed(value):
	rootBoneIndex = value


func _on_other_bone_index_spin_box_value_changed(value):
	otherBoneIndex = value


func _on_another_bone_index_spin_box_value_changed(value):
	anotherBoneIndex = value


func _on_pelvis_index_spin_box_value_changed(value):
	pelvisIndex = value