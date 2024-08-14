extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 15
var buttonToggled = false

#hkbModifierList Values
@export var nodeName = "RigidBodyRagdollControlsModifier"
@export var userData = 0
@export var enable = true
@export var hierarchyGain = "0.0"
@export var velocityDamping = "0.0"
@export var accelerationGain = "0.0"
@export var velocityGain = "0.0"
@export var positionGain = "0.0"
@export var positionMaxLinearVelocity = "0.0"
@export var positionMaxAngularVelocity = "0.0"
@export var snapGain = "0.0"
@export var snapMaxLinearVelocity = "0.0"
@export var snapMaxAngularVelocity = "0.0"
@export var snapMaxLinearDistance = "0.0"
@export var snapMaxAngularDistance = "0.0"
@export var durationToBlend = "1.0"
@export var animationBlendFraction = "1.0"

# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	$Name.text = nodeName
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/userData/userDataButton.selected = userData
	if enable:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enable/enableButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enable/enableButton.selected = 0
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/hierarchyGain/hierarchyGainLine.text = hierarchyGain
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/velocityDamping/velocityDampingLine.text = velocityDamping
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/accelerationGain/accelerationGainLine.text = accelerationGain
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/velocityGain/velocityGainLine.text = velocityGain
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/positionGain/positionGainLine.text = positionGain
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/positionMaxLinearVelocity/positionMaxLinearVelocityLine.text = positionMaxLinearVelocity
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/positionMaxAngularVelocity/positionMaxAngularVelocityLine.text = positionMaxAngularVelocity
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/snapGain/snapGainLine.text = snapGain
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/snapMaxLinearVelocity/snapMaxLinearVelocityLine.text = snapMaxLinearVelocity
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/snapMaxAngularVelocity/snapMaxAngularVelocityLine.text = snapMaxAngularVelocity
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/snapMaxLinearDistance/snapMaxLinearDistanceLine.text = snapMaxLinearDistance
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/snapMaxAngularDistance/snapMaxAngularDistanceLine.text = snapMaxAngularDistance
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/durationToBlend/durationToBlendLine.text = durationToBlend
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
	self.title = 'hkbRigidBodyRagdollControlsModifier - #' + str(nodeID)

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


func _on_hierarchy_gain_line_text_changed(new_text):
	hierarchyGain = new_text


func _on_velocity_damping_line_text_changed(new_text):
	velocityDamping = new_text


func _on_acceleration_gain_line_text_changed(new_text):
	accelerationGain = new_text


func _on_velocity_gain_line_text_changed(new_text):
	velocityGain = new_text


func _on_position_gain_line_text_changed(new_text):
	positionGain = new_text


func _on_position_max_linear_velocity_line_text_changed(new_text):
	positionMaxLinearVelocity = new_text


func _on_position_max_angular_velocity_line_text_changed(new_text):
	positionMaxAngularVelocity = new_text


func _on_snap_gain_line_text_changed(new_text):
	snapGain = new_text


func _on_snap_max_linear_velocity_line_text_changed(new_text):
	snapMaxLinearVelocity = new_text


func _on_snap_max_angular_velocity_line_text_changed(new_text):
	snapMaxAngularVelocity = new_text


func _on_snap_max_linear_distance_line_text_changed(new_text):
	snapMaxLinearDistance = new_text


func _on_snap_max_angular_distance_line_text_changed(new_text):
	snapMaxAngularDistance = new_text


func _on_duration_to_blend_line_text_changed(new_text):
	durationToBlend = new_text


func _on_animation_blend_fraction_line_text_changed(new_text):
	animationBlendFraction = new_text
