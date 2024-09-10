extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 49
@export var nodeColorID = 0
var buttonToggled = false

#hkbDampingModifier Values
@export var nodeName = "DampingModifier"
@export var userData = 0
@export var enable = true
@export var kP = "0.0"
@export var kI = "0.0"
@export var kD = "-0.0"
@export var enableScalarDamping = true
@export var enableVectorDamping = false
@export var rawValue = "0.0"
@export var dampedValue = "0.0"
@export var rawVector = "(0.0 0.0 0.0 0.0)"
@export var dampedVector = "(0.0 0.0 0.0 0.0)"
@export var vecErrorSum = "(0.0 0.0 0.0 0.0)"
@export var vecPreviousError = "(0.0 0.0 0.0 0.0)"
@export var errorSum = "0.0"
@export var previousError = "0.0"

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
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/kP/kPLine.text = kP
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/kI/kILine.text = kI
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/kD/kDLine.text = kD
	if enableScalarDamping:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enableScalarDamping/enableScalarDampingButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enableScalarDamping/enableScalarDampingButton.selected = 0
	if enableVectorDamping:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enableVectorDamping/enableVectorDampingButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enableVectorDamping/enableVectorDampingButton.selected = 0
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/rawValue/rawValueLine.text = rawValue
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/dampedValue/dampedValueLine.text = dampedValue
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/rawVector/rawVectorLine.text = rawVector
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/dampedVector/dampedVectorLine.text = dampedVector
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/vecErrorSum/vecErrorSumLine.text = vecErrorSum
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/vecPreviousError/vecPreviousErrorLine.text = vecPreviousError
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/errorSum/errorSumLine.text = errorSum
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/previousError/previousErrorLine.text = previousError


# Pop-up Handler

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
	self.title = 'hkbDampingModifier - #' + str(nodeID)

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

# Values

func _on_name_text_changed(new_text):
	nodeName = new_text

func _on_user_data_button_item_selected(index):
	userData = index

func _on_enable_button_item_selected(index):
	if index == 1:
		enable = true
	else:
		enable = false

func _on_k_p_line_text_changed(new_text):
	kP = new_text

func _on_k_i_line_text_changed(new_text):
	kI = new_text

func _on_k_d_line_text_changed(new_text):
	kD = new_text

func _on_enable_scalar_damping_button_item_selected(index):
	if index == 1:
		enableScalarDamping = true
	else:
		enableScalarDamping = false

func _on_enable_vector_damping_button_item_selected(index):
	if index == 1:
		enableVectorDamping = true
	else:
		enableVectorDamping = false

func _on_raw_value_line_text_changed(new_text):
	rawValue = new_text

func _on_damped_value_line_text_changed(new_text):
	dampedValue = new_text

func _on_raw_vector_line_text_changed(new_text):
	rawVector = new_text

func _on_damped_vector_line_text_changed(new_text):
	dampedVector = new_text

func _on_vec_error_sum_line_text_changed(new_text):
	vecErrorSum = new_text

func _on_vec_previous_error_line_text_changed(new_text):
	vecPreviousError = new_text

func _on_error_sum_line_text_changed(new_text):
	errorSum = new_text

func _on_previous_error_line_text_changed(new_text):
	previousError = new_text
