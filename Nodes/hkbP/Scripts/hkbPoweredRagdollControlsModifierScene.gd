extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 29
@export var nodeColorID = 0
var buttonToggled = false

#hkbPoweredRagdollControlsModifier Values
@export var nodeName = "PoweredRagdollControlsModifier"
@export var userData = 0
@export var enable = true
@export var maxForce = "0.0"
@export var tau = "0.0"
@export var damping = "0.0"
@export var proportionalRecoveryVelocity = "0.0"
@export var constantRecoveryVelocity = "0.0"
@export var poseMatchingBone0 = 0
@export var poseMatchingBone1 = 0
@export var poseMatchingBone2 = 0
@export var mode = 0
@export var animationBlendFraction = "0.0"

# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	change_theme(nodeColorID)
	$Name.text = nodeName
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/userData/userDataButton.selected = userData
	if enable:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enable/enableButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enable/enableButton.selected = 0
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/maxForce/maxForceLine.text = maxForce
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/tau/tauLine.text = tau
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/damping/dampingLine.text = damping
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/proportionalRecoveryVelocity/proportionalRecoveryVelocityLine.text = proportionalRecoveryVelocity
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/constantRecoveryVelocity/constantRecoveryVelocityLine.text = constantRecoveryVelocity
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/poseMatchingBone0/poseMatchingBone0SpinBox.value = poseMatchingBone0
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/poseMatchingBone1/poseMatchingBone1SpinBox.value = poseMatchingBone1
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/poseMatchingBone2/poseMatchingBone2SpinBox.value = poseMatchingBone2
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/mode/modeButton.selected = mode
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/animationBlendFraction/animationBlendFractionLine.text = animationBlendFraction

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
	self.title = 'hkbPoweredRagdollControlsModifier - #' + str(nodeID)

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
			set_slot_color_left(0, Color(1,1,1,1))
			set_slot_color_right(0, Color(1,1,1,1))
			set_slot_color_right(1, Color(1,1,1,1))
			set_slot_color_right(2, Color(1,1,1,1))
			set_slot_color_right(3, Color(1,1,1,1))
			set_slot_color_right(4, Color(1,1,1,1))
			set_slot_color_right(5, Color(1,1,1,1))
		1:
			self.set_theme(globalVariable.redTheme)
			set_slot_color_left(0, Color(1,0.4,0.35,1))
			set_slot_color_right(0, Color(1,0.4,0.35,1))
			set_slot_color_right(1, Color(1,0.4,0.35,1))
			set_slot_color_right(2, Color(1,0.4,0.35,1))
			set_slot_color_right(3, Color(1,0.4,0.35,1))
			set_slot_color_right(4, Color(1,0.4,0.35,1))
			set_slot_color_right(5, Color(1,0.4,0.35,1))
		2:
			self.set_theme(globalVariable.orangeTheme)
			set_slot_color_left(0, Color(0.9,0.55,0.3,1))
			set_slot_color_right(1, Color(0.9,0.55,0.3,1))
			set_slot_color_right(2, Color(0.9,0.55,0.3,1))
			set_slot_color_right(3, Color(0.9,0.55,0.3,1))
			set_slot_color_right(4, Color(0.9,0.55,0.3,1))
			set_slot_color_right(5, Color(0.9,0.55,0.3,1))
			set_slot_color_right(6, Color(0.9,0.55,0.3,1))
		3:
			self.set_theme(globalVariable.yellowTheme)
			set_slot_color_left(0, Color(1,0.9,0.4,1))
			set_slot_color_right(1, Color(1,0.9,0.4,1))
			set_slot_color_right(2, Color(1,0.9,0.4,1))
			set_slot_color_right(3, Color(1,0.9,0.4,1))
			set_slot_color_right(4, Color(1,0.9,0.4,1))
			set_slot_color_right(5, Color(1,0.9,0.4,1))
			set_slot_color_right(6, Color(1,0.9,0.4,1))
		4:
			self.set_theme(globalVariable.brownTheme)
			set_slot_color_left(0, Color(0.7,0.6,0.5,1))
			set_slot_color_right(1, Color(0.7,0.6,0.5,1))
			set_slot_color_right(2, Color(0.7,0.6,0.5,1))
			set_slot_color_right(3, Color(0.7,0.6,0.5,1))
			set_slot_color_right(4, Color(0.7,0.6,0.5,1))
			set_slot_color_right(5, Color(0.7,0.6,0.5,1))
			set_slot_color_right(6, Color(0.7,0.6,0.5,1))
		5:
			self.set_theme(globalVariable.greenTheme)
			set_slot_color_left(0, Color(0.7,0.8,0.4,1))
			set_slot_color_right(1, Color(0.7,0.8,0.4,1))
			set_slot_color_right(2, Color(0.7,0.8,0.4,1))
			set_slot_color_right(3, Color(0.7,0.8,0.4,1))
			set_slot_color_right(4, Color(0.7,0.8,0.4,1))
			set_slot_color_right(5, Color(0.7,0.8,0.4,1))
			set_slot_color_right(6, Color(0.7,0.8,0.4,1))
		6:
			self.set_theme(globalVariable.emeraldTheme)
			set_slot_color_left(0, Color(0.5,0.8,0.5,1))
			set_slot_color_right(1, Color(0.5,0.8,0.5,1))
			set_slot_color_right(2, Color(0.5,0.8,0.5,1))
			set_slot_color_right(3, Color(0.5,0.8,0.5,1))
			set_slot_color_right(4, Color(0.5,0.8,0.5,1))
			set_slot_color_right(5, Color(0.5,0.8,0.5,1))
			set_slot_color_right(6, Color(0.5,0.8,0.5,1))
		7:
			self.set_theme(globalVariable.ceruleanTheme)
			set_slot_color_left(0, Color(0.4,0.7,0.7,1))
			set_slot_color_right(1, Color(0.4,0.7,0.7,1))
			set_slot_color_right(2, Color(0.4,0.7,0.7,1))
			set_slot_color_right(3, Color(0.4,0.7,0.7,1))
			set_slot_color_right(4, Color(0.4,0.7,0.7,1))
			set_slot_color_right(5, Color(0.4,0.7,0.7,1))
			set_slot_color_right(6, Color(0.4,0.7,0.7,1))
		8:
			self.set_theme(globalVariable.blueTheme)
			set_slot_color_left(0, Color(0.45,0.65,0.75,1))
			set_slot_color_right(1, Color(0.45,0.65,0.75,1))
			set_slot_color_right(2, Color(0.45,0.65,0.75,1))
			set_slot_color_right(3, Color(0.45,0.65,0.75,1))
			set_slot_color_right(4, Color(0.45,0.65,0.75,1))
			set_slot_color_right(5, Color(0.45,0.65,0.75,1))
			set_slot_color_right(6, Color(0.45,0.65,0.75,1))
		9:
			self.set_theme(globalVariable.deepBlueTheme)
			set_slot_color_left(0, Color(0.3,0.3,0.7,1))
			set_slot_color_right(1, Color(0.3,0.3,0.7,1))
			set_slot_color_right(2, Color(0.3,0.3,0.7,1))
			set_slot_color_right(3, Color(0.3,0.3,0.7,1))
			set_slot_color_right(4, Color(0.3,0.3,0.7,1))
			set_slot_color_right(5, Color(0.3,0.3,0.7,1))
			set_slot_color_right(6, Color(0.3,0.3,0.7,1))
		10:
			self.set_theme(globalVariable.purpleTheme)
			set_slot_color_left(0, Color(0.6,0.45,0.7,1))
			set_slot_color_right(1, Color(0.6,0.45,0.7,1))
			set_slot_color_right(2, Color(0.6,0.45,0.7,1))
			set_slot_color_right(3, Color(0.6,0.45,0.7,1))
			set_slot_color_right(4, Color(0.6,0.45,0.7,1))
			set_slot_color_right(5, Color(0.6,0.45,0.7,1))
			set_slot_color_right(6, Color(0.6,0.45,0.7,1))
		11:
			self.set_theme(globalVariable.eggplantTheme)
			set_slot_color_left(0, Color(0.7,0.4,0.6,1))
			set_slot_color_right(1, Color(0.7,0.4,0.6,1))
			set_slot_color_right(2, Color(0.7,0.4,0.6,1))
			set_slot_color_right(3, Color(0.7,0.4,0.6,1))
			set_slot_color_right(4, Color(0.7,0.4,0.6,1))
			set_slot_color_right(5, Color(0.7,0.4,0.6,1))
			set_slot_color_right(6, Color(0.7,0.4,0.6,1))

func _on_name_text_changed(new_text):
	nodeName = new_text

func _on_user_data_button_item_selected(index):
	userData = index

func _on_enable_button_item_selected(index):
	if index == 1:
		enable = true
	else:
		enable = false

func _on_max_force_line_text_changed(new_text):
	maxForce = new_text

func _on_tau_line_text_changed(new_text):
	tau  = new_text

func _on_damping_line_text_changed(new_text):
	damping = new_text

func _on_proportional_recovery_velocity_line_text_changed(new_text):
	proportionalRecoveryVelocity = new_text

func _on_constant_recovery_velocity_line_text_changed(new_text):
	constantRecoveryVelocity = new_text

func _on_pose_matching_bone_0_spin_box_value_changed(value):
	poseMatchingBone0 = value

func _on_pose_matching_bone_1_spin_box_value_changed(value):
	poseMatchingBone1 = value

func _on_pose_matching_bone_2_spin_box_value_changed(value):
	poseMatchingBone2 = value

func _on_mode_button_item_selected(index):
	mode = index

func _on_animation_blend_fraction_line_text_changed(new_text):
	animationBlendFraction = new_text
