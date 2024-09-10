extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 22
@export var nodeColorID = 0
var buttonToggled = false

#hkbPoseMatchingGenerator Values
@export var nodeName = "PoseMatchingGenerator"
@export var userData = 0
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
	change_theme(nodeColorID)
	$Name.text = nodeName
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/userData/userDataButton.selected = userData
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/blendParameter/blendParameterLine.text = blendParameter
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/blendSpeed/blendSpeedLine.text = blendSpeed
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/minSpeedToSwitch/minSpeedToSwitchLine.text = minSpeedToSwitch
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startPlayingEventId/startPlayingEventIdOptionButton._updateEvents()
	if startPlayingEventId == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startPlayingEventId/startPlayingEventIdOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startPlayingEventId/startPlayingEventIdOptionButton.selected = startPlayingEventId + 1
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startMatchingEventId/startMatchingEventIdOptionButton._updateEvents()
	if startMatchingEventId == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startMatchingEventId/startMatchingEventIdOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startMatchingEventId/startMatchingEventIdOptionButton.selected = startMatchingEventId + 1
	#$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startPlayingEventId/startPlayingEventIdSpinBox.value = startPlayingEventId
	#$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startMatchingEventId/startMatchingEventIdSpinBox.value = startMatchingEventId
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
	self.selected = false
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
	parentGraph.get_parent().selected_nodes = []
	self.queue_free()

func _on_pin_button_toggled(toggled_on):
	buttonToggled = toggled_on
	$DataPopupPanel/VBoxContainer/BaseNode/PinButton/PinIcon.visible = !buttonToggled
	$DataPopupPanel/VBoxContainer/BaseNode/PinButton/UnpinIcon.visible = buttonToggled
	$DataPopupPanel.popup_window = !buttonToggled

func _on_paint_button_pressed():
	nodeColorID += 1
	if nodeColorID > 11:
		nodeColorID = 0
	change_theme(nodeColorID)

func change_theme(index):
	match index:
		0:
			self.set_theme(globalVariable.defaultTheme)
		1:
			self.set_theme(globalVariable.redTheme)
		2:
			self.set_theme(globalVariable.orangeTheme)
		3:
			self.set_theme(globalVariable.yellowTheme)
		4:
			self.set_theme(globalVariable.brownTheme)
		5:
			self.set_theme(globalVariable.greenTheme)
		6:
			self.set_theme(globalVariable.emeraldTheme)
		7:
			self.set_theme(globalVariable.ceruleanTheme)
		8:
			self.set_theme(globalVariable.blueTheme)
		9:
			self.set_theme(globalVariable.deepBlueTheme)
		10:
			self.set_theme(globalVariable.purpleTheme)
		11:
			self.set_theme(globalVariable.eggplantTheme)

func _on_name_text_changed(new_text):
	nodeName = new_text

func _on_user_data_button_item_selected(index):
	userData = index

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


func _on_start_playing_event_id_option_button_item_selected(index):
	pass # Replace with function body.


func _on_start_matching_event_id_option_button_item_selected(index):
	pass # Replace with function body.


func _on_update_events_button_pressed():
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startPlayingEventId/startPlayingEventIdOptionButton._updateEvents()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startMatchingEventId/startMatchingEventIdOptionButton._updateEvents()
