extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 18
@export var nodeColorID = 0
var buttonToggled = false

#hkbManualSelectorGenerator Values
@export var nodeName = "ManualSelectorGenerator"
@export var userData = 0
@export var enable = true
@export var selectedGeneratorIndex = 0
@export var selectedIndexCanChangeAfterActivate = true
@export var generatorChangedTransitionEffect = 0


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
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/selectedGeneratorIndex/selectedGeneratorIndexSpinBox.value = selectedGeneratorIndex
	if selectedIndexCanChangeAfterActivate:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/selectedIndexCanChangeAfterActivate/selectedIndexCanChangeAfterActivateButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/selectedIndexCanChangeAfterActivate/selectedIndexCanChangeAfterActivateButton.selected = 0
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/generatorChangedTransitionEffect/generatorChangedTransitionEffectButton.selected = generatorChangedTransitionEffect


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
	self.title = 'hkbManualSelectorGenerator - #' + str(nodeID)

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

func _on_name_text_changed(new_text):
	nodeName = new_text

func _on_user_data_button_item_selected(index):
	userData = index

func _on_enable_button_item_selected(index):
	if index == 1:
		enable = true
	else:
		enable = false

func _on_selected_generator_index_spin_box_value_changed(value):
	selectedGeneratorIndex = value

func _on_selected_index_can_change_after_activate_button_item_selected(index):
	if index == 1:
		selectedIndexCanChangeAfterActivate = true
	else:
		selectedIndexCanChangeAfterActivate = false


func _on_generator_changed_transition_effect_button_item_selected(index):
	generatorChangedTransitionEffect = index


func _on_update_transitions_button_pressed():
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/generatorChangedTransitionEffect/generatorChangedTransitionEffectButton.updateTransitions()
