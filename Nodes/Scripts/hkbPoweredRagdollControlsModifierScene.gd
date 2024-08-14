extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 29
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
