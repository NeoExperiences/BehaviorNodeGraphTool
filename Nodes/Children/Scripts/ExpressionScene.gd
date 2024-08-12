extends PanelContainer

# Binding Variables
var expressionIndex = 1
var expression = ""
var assignmentVariableIndex = -1
var assignmentEventIndex = -1

func _ready():
	$ExpressionContainer/PanelContainer/ExpressionNameLabel.text = "Expression #" + str(expressionIndex)
	$ExpressionContainer/dataContainer/expression/expressionLineEdit.text = expression
	$ExpressionContainer/dataContainer/assignmentVariableIndex/assignmentVariableIndexSpinBox.value = assignmentVariableIndex
	$ExpressionContainer/dataContainer/assignmentEventIndex/assignmentEventIndexSpinBox.value = assignmentEventIndex

func update_values():
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()._on_update_expression_array()

func _on_expression_line_edit_text_changed(new_text):
	expression = new_text
	update_values()

func _on_assignment_variable_index_spin_box_value_changed(value):
	assignmentVariableIndex = value
	update_values()

func _on_assignment_event_index_spin_box_value_changed(value):
	assignmentEventIndex = value
	update_values()

func _on_show_button_pressed():
	if !$ExpressionContainer/dataContainer.visible:
		$ExpressionContainer/dataContainer.visible = 1
		$ExpressionContainer/ShowButton.text = "Hide Data"
	else:
		$ExpressionContainer/dataContainer.visible = 0
		$ExpressionContainer/ShowButton.text = "Show Data"


