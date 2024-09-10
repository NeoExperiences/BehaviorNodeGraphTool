extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 16
@export var nodeColorID = 0
var buttonToggled = false

#hkbModifierGenerator Values
@export var nodeName = "BSIsActiveModifier"
@export var userData = 0
@export var enable = true
@export var bIsActiveArray = [false, false, false, false, false, false, false, false, false, false]

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
	if bIsActiveArray[0]:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bIsActive0/bIsActive0Button.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bIsActive0/bIsActive0Button.selected = 0
	if bIsActiveArray[1]:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bIsActive1/bIsActive1Button.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bIsActive1/bIsActive1Button.selected = 0
	if bIsActiveArray[2]:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bIsActive2/bIsActive2Button.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bIsActive2/bIsActive2Button.selected = 0
	if bIsActiveArray[3]:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bIsActive3/bIsActive3Button.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bIsActive3/bIsActive3Button.selected = 0
	if bIsActiveArray[4]:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bIsActive4/bIsActive4Button.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bIsActive4/bIsActive4Button.selected = 0
	if bIsActiveArray[5]:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bInvertActive0/bInvertActive0Button.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bInvertActive0/bInvertActive0Button.selected = 0
	if bIsActiveArray[6]:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bInvertActive1/bInvertActive1Button.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bInvertActive1/bInvertActive1Button.selected = 0
	if bIsActiveArray[7]:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bInvertActive2/bInvertActive2Button.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bInvertActive2/bInvertActive2Button.selected = 0
	if bIsActiveArray[8]:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bInvertActive3/bInvertActive3Button.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bInvertActive3/bInvertActive3Button.selected = 0
	if bIsActiveArray[9]:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bInvertActive4/bInvertActive4Button.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/bInvertActive4/bInvertActive4Button.selected = 0
	
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

func _on_node_id_spin_box_value_changed(value):
	nodeID = value
	self.title = 'BSIsActiveModifier - #' + str(nodeID)

func _on_edit_button_pressed():
	show_popup()

func _on_delete_button_pressed():
	$DataPopupPanel/VBoxContainer/BaseNode/DeleteButton.hide()
	$DataPopupPanel/VBoxContainer/BaseNode/ConfirmDeleteButton.show()

func _on_confirm_delete_button_pressed():
	var parentGraph = get_parent()
	parentGraph.remove_child(self)
	self.queue_free()

func _on_pin_button_pressed():
	pass # Replace with function body.

func _on_name_text_changed(new_text):
	nodeName = new_text

func _on_user_data_button_item_selected(index):
	userData = index

func _on_enable_button_item_selected(index):
	if index == 1:
		enable = true
	else:
		enable = false

func _on_b_is_active_0_button_item_selected(index):
	if index == 1:
		bIsActiveArray[0] = true
	else:
		bIsActiveArray[0] = false

func _on_b_is_active_1_button_item_selected(index):
	if index == 1:
		bIsActiveArray[1] = true
	else:
		bIsActiveArray[1] = false

func _on_b_is_active_2_button_item_selected(index):
	if index == 1:
		bIsActiveArray[2] = true
	else:
		bIsActiveArray[2] = false

func _on_b_is_active_3_button_item_selected(index):
	if index == 1:
		bIsActiveArray[3] = true
	else:
		bIsActiveArray[3] = false

func _on_b_is_active_4_button_item_selected(index):
	if index == 1:
		bIsActiveArray[4] = true
	else:
		bIsActiveArray[4] = false

func _on_b_invert_active_0_button_item_selected(index):
	if index == 1:
		bIsActiveArray[5] = true
	else:
		bIsActiveArray[5] = false

func _on_b_invert_active_1_button_item_selected(index):
	if index == 1:
		bIsActiveArray[6] = true
	else:
		bIsActiveArray[6] = false

func _on_b_invert_active_2_button_item_selected(index):
	if index == 1:
		bIsActiveArray[7] = true
	else:
		bIsActiveArray[7] = false

func _on_b_invert_active_3_button_item_selected(index):
	if index == 1:
		bIsActiveArray[8] = true
	else:
		bIsActiveArray[8] = false

func _on_b_invert_active_4_button_item_selected(index):
	if index == 1:
		bIsActiveArray[9] = true
	else:
		bIsActiveArray[9] = false




