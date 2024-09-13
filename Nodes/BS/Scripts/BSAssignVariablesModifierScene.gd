extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 43
@export var nodeColorID = 0
var buttonToggled = false

#BSAssignVariablesModifier Values
@export var nodeName = "AssignVariablesModifier"
@export var userData = 0
@export var enable = true
@export var floatVariable = ["0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0"]
@export var floatValue = ["0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0","0.0"]
@export var intVariable = [0, 0, 0, 0]
@export var intValue = [0, 0, 0, 0]

# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	change_theme(nodeColorID)
	$Name.text = nodeName
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/userData/userDataButton.selected = userData
	if enable:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/enable/enableButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/enable/enableButton.selected = 0
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable1/floatVariable1Line.text = floatVariable[0]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable2/floatVariable2Line.text = floatVariable[1]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable3/floatVariable3Line.text = floatVariable[2]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable4/floatVariable4Line.text = floatVariable[3]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable5/floatVariable5Line.text = floatVariable[4]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable6/floatVariable6Line.text = floatVariable[5]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable7/floatVariable7Line.text = floatVariable[6]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable8/floatVariable8Line.text = floatVariable[7]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable9/floatVariable9Line.text = floatVariable[8]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable10/floatVariable10Line.text = floatVariable[9]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable11/floatVariable11Line.text = floatVariable[10]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable12/floatVariable12Line.text = floatVariable[11]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable13/floatVariable13Line.text = floatVariable[12]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable14/floatVariable14Line.text = floatVariable[13]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable15/floatVariable15Line.text = floatVariable[14]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable16/floatVariable16Line.text = floatVariable[15]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable17/floatVariable17Line.text = floatVariable[16]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable18/floatVariable18Line.text = floatVariable[17]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable19/floatVariable19Line.text = floatVariable[18]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatVariable20/floatVariable20Line.text = floatVariable[19]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue1/floatValue1Line.text = floatValue[0]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue2/floatValue2Line.text = floatValue[1]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue3/floatValue3Line.text = floatValue[2]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue4/floatValue4Line.text = floatValue[3]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue5/floatValue5Line.text = floatValue[4]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue6/floatValue6Line.text = floatValue[5]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue7/floatValue7Line.text = floatValue[6]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue8/floatValue8Line.text = floatValue[7]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue9/floatValue9Line.text = floatValue[8]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue10/floatValue10Line.text = floatValue[9]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue11/floatValue11Line.text = floatValue[10]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue12/floatValue12Line.text = floatValue[11]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue13/floatValue13Line.text = floatValue[12]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue14/floatValue14Line.text = floatValue[13]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue15/floatValue15Line.text = floatValue[14]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue16/floatValue16Line.text = floatValue[15]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue17/floatValue17Line.text = floatValue[16]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue18/floatValue18Line.text = floatValue[17]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue19/floatValue19Line.text = floatValue[18]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/floatValue20/floatValue20Line.text = floatValue[19]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/intVariable1/intVariable1SpinBox.value = intVariable[0]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/intVariable2/intVariable2SpinBox.value = intVariable[1]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/intVariable3/intVariable3SpinBox.value = intVariable[2]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/intVariable4/intVariable4SpinBox.value = intVariable[3]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/intValue1/intValue1SpinBox.value = intValue[0]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/intValue2/intValue2SpinBox.value = intValue[1]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/intValue3/intValue3SpinBox.value = intValue[2]
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer/intValue4/intValue4SpinBox.value = intValue[3]

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
	self.title = 'BSAssignVariablesModifier - #' + str(nodeID)

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

func _on_float_variable_1_line_text_changed(new_text):
	floatVariable[0] = new_text

func _on_float_variable_2_line_text_changed(new_text):
	floatVariable[1] = new_text

func _on_float_variable_3_line_text_changed(new_text):
	floatVariable[2] = new_text

func _on_float_variable_4_line_text_changed(new_text):
	floatVariable[3] = new_text

func _on_float_variable_5_line_text_changed(new_text):
	floatVariable[4] = new_text

func _on_float_variable_6_line_text_changed(new_text):
	floatVariable[5] = new_text

func _on_float_variable_7_line_text_changed(new_text):
	floatVariable[6] = new_text

func _on_float_variable_8_line_text_changed(new_text):
	floatVariable[7] = new_text

func _on_float_variable_9_line_text_changed(new_text):
	floatVariable[8] = new_text

func _on_float_variable_10_line_text_changed(new_text):
	floatVariable[9] = new_text

func _on_float_variable_11_line_text_changed(new_text):
	floatVariable[10] = new_text

func _on_float_variable_12_line_text_changed(new_text):
	floatVariable[11] = new_text

func _on_float_variable_13_line_text_changed(new_text):
	floatVariable[12] = new_text

func _on_float_variable_14_line_text_changed(new_text):
	floatVariable[13] = new_text

func _on_float_variable_15_line_text_changed(new_text):
	floatVariable[14] = new_text

func _on_float_variable_16_line_text_changed(new_text):
	floatVariable[15] = new_text

func _on_float_variable_17_line_text_changed(new_text):
	floatVariable[16] = new_text

func _on_float_variable_18_line_text_changed(new_text):
	floatVariable[17] = new_text

func _on_float_variable_19_line_text_changed(new_text):
	floatVariable[18] = new_text

func _on_float_variable_20_line_text_changed(new_text):
	floatVariable[19] = new_text

func _on_float_value_1_line_text_changed(new_text):
	floatValue[0] = new_text

func _on_float_value_2_line_text_changed(new_text):
	floatValue[1] = new_text

func _on_float_value_3_line_text_changed(new_text):
	floatValue[2] = new_text

func _on_float_value_4_line_text_changed(new_text):
	floatValue[3] = new_text

func _on_float_value_5_line_text_changed(new_text):
	floatValue[4] = new_text

func _on_float_value_6_line_text_changed(new_text):
	floatValue[5] = new_text

func _on_float_value_7_line_text_changed(new_text):
	floatValue[6] = new_text

func _on_float_value_8_line_text_changed(new_text):
	floatValue[7] = new_text

func _on_float_value_9_line_text_changed(new_text):
	floatValue[8] = new_text

func _on_float_value_10_line_text_changed(new_text):
	floatValue[9] = new_text

func _on_float_value_11_line_text_changed(new_text):
	floatValue[10] = new_text

func _on_float_value_12_line_text_changed(new_text):
	floatValue[11] = new_text

func _on_float_value_13_line_text_changed(new_text):
	floatValue[12] = new_text

func _on_float_value_14_line_text_changed(new_text):
	floatValue[13] = new_text

func _on_float_value_15_line_text_changed(new_text):
	floatValue[14] = new_text

func _on_float_value_16_line_text_changed(new_text):
	floatValue[15] = new_text

func _on_float_value_17_line_text_changed(new_text):
	floatValue[16] = new_text

func _on_float_value_18_line_text_changed(new_text):
	floatValue[17] = new_text

func _on_float_value_19_line_text_changed(new_text):
	floatValue[18] = new_text

func _on_float_value_20_line_text_changed(new_text):
	floatValue[19] = new_text

func _on_int_variable_1_spin_box_value_changed(value):
	intVariable[0] = value
	
func _on_int_variable_2_spin_box_value_changed(value):
	intVariable[1] = value
	
func _on_int_variable_3_spin_box_value_changed(value):
	intVariable[2] = value
	
func _on_int_variable_4_spin_box_value_changed(value):
	intVariable[3] = value
	
func _on_int_value_1_spin_box_value_changed(value):
	intValue[0] = value

func _on_int_value_2_spin_box_value_changed(value):
	intValue[1] = value

func _on_int_value_3_spin_box_value_changed(value):
	intValue[2] = value

func _on_int_value_4_spin_box_value_changed(value):
	intValue[3] = value


