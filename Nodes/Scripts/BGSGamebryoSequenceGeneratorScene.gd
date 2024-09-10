extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 40
@export var nodeColorID = 0
var buttonToggled = false

#BGSGamebryoSequenceGenerator Values
@export var nodeName = "SequenceGenerator"
@export var pSequence = "SequenceName"
@export var userData = 0
@export var eBlendModeFunction = "BMF_NONE"
@export var fPercent = "1.0"
@export var eUseTimePercentage = "USING_TIME_PERCENTAGE"
@export var fTimePercent = "0.0"

# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	change_theme(nodeColorID)
	$Name.text = nodeName
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/userData/userDataButton.selected = userData
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/pSequence/pSequenceLine.text = pSequence
	if eBlendModeFunction == "BMF_NONE":
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/eBlendModeFunction/eBlendModeFunctionButton.selected = 0
	elif eBlendModeFunction == "BMF_ONE_MINUS_PERCENT":
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/eBlendModeFunction/eBlendModeFunctionButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/eBlendModeFunction/eBlendModeFunctionButton.selected = 2
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/fPercent/fPercentLine.text = fPercent
	if eUseTimePercentage == "USING_TIME_PERCENTAGE":
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/eUseTimePercentage/eUseTimePercentage.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/eUseTimePercentage/eUseTimePercentage.selected = 1
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/fTimePercent/fTimePercentLine.text = fTimePercent


func _on_p_sequence_line_text_changed(new_text):
	pSequence = new_text

func _on_e_blend_mode_function_button_item_selected(index):
	match index:
		0:
			eBlendModeFunction = "BMF_NONE"
		1:
			eBlendModeFunction = "BMF_ONE_MINUS_PERCENT"
		2:
			eBlendModeFunction = "BMF_PERCENT"

func _on_f_percent_line_text_changed(new_text):
	fPercent = new_text

func _on_e_use_time_percentage_item_selected(index):
	match index:
		0:
			eUseTimePercentage = "USING_TIME_PERCENTAGE"
		1:
			eUseTimePercentage = "NOT_USING_TIME_PERCENTAGE"

func _on_f_time_percent_line_text_changed(new_text):
	fTimePercent = new_text

func _on_user_data_button_item_selected(index):
	userData = index

# UI STUFF

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
	self.title = 'BGSGamebryoSequenceGenerator - #' + str(nodeID)

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
