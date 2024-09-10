extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 33
@export var nodeColorID = 0
var buttonToggled = false

#hkbTwistModifier Values
@export var nodeName = "TwistModifier"
@export var userData = 0
@export var enable = true
@export var axisOfRotation = "(0.0 0.0 0.0 0.0)"
@export var twistAngle = "0.0"
@export var startBoneIndex = 0
@export var endBoneIndex = 0
@export var setAngleMethod = 0
@export var rotationAxisCoordinates = 0
@export var isAdditive = true

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
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/axisOfRotation/axisOfRotationLine.text = axisOfRotation
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/twistAngle/twistAngleLine.text = twistAngle
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/startBoneIndex/startBoneIndexSpinBox.value = startBoneIndex
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/endBoneIndex/endBoneIndexSpinBox.value = endBoneIndex
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/setAngleMethod/setAngleMethodButton.selected = setAngleMethod
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/rotationAxisCoordinates/rotationAxisCoordinatesButton.selected = rotationAxisCoordinates
	if isAdditive:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/isAdditive/isAdditiveButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/isAdditive/isAdditiveButton.selected = 0
	

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
	self.title = 'hkbTwistModifier - #' + str(nodeID)

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

func _on_enable_button_item_selected(index):
	if index == 1:
		enable = true
	else:
		enable = false

func _on_axis_of_rotation_line_text_changed(new_text):
	axisOfRotation = new_text

func _on_twist_angle_line_text_changed(new_text):
	twistAngle = new_text

func _on_start_bone_index_spin_box_value_changed(value):
	startBoneIndex = value

func _on_end_bone_index_spin_box_value_changed(value):
	endBoneIndex = value

func _on_set_angle_method_button_item_selected(index):
	setAngleMethod = index

func _on_rotation_axis_coordinates_button_item_selected(index):
	rotationAxisCoordinates = index

func _on_is_additive_button_item_selected(index):
	if index == 1:
		isAdditive = true
	else:
		isAdditive = false
