extends PanelContainer

# Binding Variables
var bindingIndex = 1
var memberPath = ""
var variableIndex = 0
var bindingType = "BINDING_TYPE_VARIABLE"

func _ready():
	_update_name()
	$bindingContainer/dataContainer/memberPath/memberPathLineEdit.text = memberPath
	$bindingContainer/dataContainer/variableIndex/variableIndexSpinBox.value = variableIndex
	if bindingType == "BINDING_TYPE_VARIABLE":
		$bindingContainer/dataContainer/bindingType/bindingTypeButton.selected = 0
	else:
		$bindingContainer/dataContainer/bindingType/bindingTypeButton.selected = 1

func _update_name():
	$bindingContainer/PanelContainer/BindingNameLabel.text = "Binding #" + str(bindingIndex)

func update_values():
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()._on_update_binding_array()

func _on_member_path_line_edit_text_changed(new_text):
	memberPath = new_text
	update_values()

func _on_variable_index_spin_box_value_changed(value):
	variableIndex = value
	update_values()

func _on_binding_type_button_item_selected(index):
	if index == 0:
		bindingType = "BINDING_TYPE_VARIABLE"
	else:
		bindingType = "BINDING_TYPE_CHARACTER_PROPERTY"
	update_values()

func _on_show_button_pressed():
	if !$bindingContainer/dataContainer.visible:
		$bindingContainer/dataContainer.visible = 1
		$bindingContainer/ShowButton.text = "Hide Data"
	else:
		$bindingContainer/dataContainer.visible = 0
		$bindingContainer/ShowButton.text = "Show Data"
	get_parent().get_parent().reset_size()
