extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 17
@export var nodeColorID = 0
var buttonToggled = false

#hkbVariableBindingSet Values
var bindingpanel = load("res://Nodes/Children/BindingScene.tscn")
var bindingIndex = 0
@export var bindingArray = []
@export var indexOfBindingToEnable = -1
@onready var bindingContainer = $DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	change_theme(nodeColorID)
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/indexOfBindingToEnable/indexOfBindingToEnableSpinBox.value = indexOfBindingToEnable
	if bindingArray:
		for binding in bindingArray:
			_load_bindings(binding.memberPath, binding.variableIndex, binding.bindingType)
	else:
		_on_add_binding_pressed()
		_on_update_binding_array()

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

func _on_node_id_spin_box_value_changed(value):
	nodeID = value
	self.title = 'hkbVariableBindingSet - #' + str(nodeID)

func _on_add_binding_pressed():
	bindingIndex += 1
	var newBinding = bindingpanel.instantiate()
	newBinding.bindingIndex = bindingIndex
	bindingContainer.add_child(newBinding)

func _on_remove_binding_pressed():
	if bindingContainer.get_child_count() > 1:
		var deletedBinding = bindingContainer.get_child(-1)
		bindingContainer.remove_child(deletedBinding)
		deletedBinding.queue_free()
		bindingIndex -= 1
		_on_update_binding_array()
		reset_size()

func _on_update_binding_array():
	bindingArray = []
	for child in bindingContainer.get_children():
		if child.get_name() != "ButtonContainer" && child.get_name() != "indexOfBindingToEnable":
			var bindingData = {
				"memberPath": child.get("memberPath"),
				"variableIndex": child.get("variableIndex"),
				"bindingType": child.get("bindingType"),
			}
			bindingArray.append(bindingData)

func _on_index_of_binding_to_enable_spin_box_value_changed(value):
	indexOfBindingToEnable = value

func _load_bindings(memberPath, variableIndex, bindingType):
	bindingIndex += 1
	var newBinding = bindingpanel.instantiate()
	newBinding.memberPath = memberPath
	newBinding.variableIndex = variableIndex
	newBinding.bindingType = bindingType
	newBinding._update_name()
	bindingContainer.add_child(newBinding)

func _on_update_variables_button_pressed():
	for child in bindingContainer.get_children():
		child._update_variable_button()
