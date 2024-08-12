extends Panel

var variableID = 0
var variableName = ""
var variableType = 0
var variableValue = "0"
var variableMinValue = "0"
var variableMaxValue = "0"
var variableQuadValues = "(0.0 0.0 0.0 0.0)"

# Called when the node enters the scene tree for the first time.
func _ready():
	$ValuesRowContainer/IDNumberContainer/IDNumberLabel.text = str(variableID)
	$ValuesRowContainer/NameContainer/NameLine.text = variableName
	$ValuesRowContainer/TypesContainer/TypesButton.selected = variableType
	$ValuesRowContainer/ValuesContainer/ValuesLine.text = variableValue
	$ValuesRowContainer/MinValuesContainer/MinValuesLine.text = variableMinValue
	$ValuesRowContainer/MaxValuesContainer/MaxValuesLine.text = variableMaxValue
	$ValuesRowContainer/QuadValuesContainer/QuadValuesLine.text = variableQuadValues
	test_available_values()

func update_variable_values():
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()._on_update_variable_list()

func _on_name_line_text_changed(new_text):
	variableName = new_text
	update_variable_values()

func _on_types_button_item_selected(index):
	variableType = index
	test_available_values()
	update_variable_values()

func test_available_values():
	match variableType:
		0: #BOOL
			$ValuesRowContainer/ValuesContainer/ValuesLine.editable = true
			$ValuesRowContainer/MinValuesContainer/MinValuesLine.editable = true
			$ValuesRowContainer/MaxValuesContainer/MaxValuesLine.editable = true
			$ValuesRowContainer/QuadValuesContainer/QuadValuesLine.editable = false
		1: #INT8
			$ValuesRowContainer/ValuesContainer/ValuesLine.editable = true
			$ValuesRowContainer/MinValuesContainer/MinValuesLine.editable = true
			$ValuesRowContainer/MaxValuesContainer/MaxValuesLine.editable = true
			$ValuesRowContainer/QuadValuesContainer/QuadValuesLine.editable = false
		2: #INT16
			$ValuesRowContainer/ValuesContainer/ValuesLine.editable = true
			$ValuesRowContainer/MinValuesContainer/MinValuesLine.editable = true
			$ValuesRowContainer/MaxValuesContainer/MaxValuesLine.editable = true
			$ValuesRowContainer/QuadValuesContainer/QuadValuesLine.editable = false
		3: #INT32
			$ValuesRowContainer/ValuesContainer/ValuesLine.editable = true
			$ValuesRowContainer/MinValuesContainer/MinValuesLine.editable = true
			$ValuesRowContainer/MaxValuesContainer/MaxValuesLine.editable = true
			$ValuesRowContainer/QuadValuesContainer/QuadValuesLine.editable = false
		4: #REAL
			$ValuesRowContainer/ValuesContainer/ValuesLine.editable = true
			$ValuesRowContainer/MinValuesContainer/MinValuesLine.editable = true
			$ValuesRowContainer/MaxValuesContainer/MaxValuesLine.editable = true
			$ValuesRowContainer/QuadValuesContainer/QuadValuesLine.editable = false
		5: #POINTER
			$ValuesRowContainer/ValuesContainer/ValuesLine.editable = false
			$ValuesRowContainer/MinValuesContainer/MinValuesLine.editable = false
			$ValuesRowContainer/MaxValuesContainer/MaxValuesLine.editable = false
			$ValuesRowContainer/QuadValuesContainer/QuadValuesLine.editable = false
		6: #VECTOR4
			$ValuesRowContainer/ValuesContainer/ValuesLine.editable = true
			$ValuesRowContainer/MinValuesContainer/MinValuesLine.editable = false
			$ValuesRowContainer/MaxValuesContainer/MaxValuesLine.editable = false
			$ValuesRowContainer/QuadValuesContainer/QuadValuesLine.editable = true
		7: #QUATERNION
			$ValuesRowContainer/ValuesContainer/ValuesLine.editable = true
			$ValuesRowContainer/MinValuesContainer/MinValuesLine.editable = false
			$ValuesRowContainer/MaxValuesContainer/MaxValuesLine.editable = false
			$ValuesRowContainer/QuadValuesContainer/QuadValuesLine.editable = true

func _on_values_line_text_changed(new_text):
	variableValue = new_text
	update_variable_values()

func _on_min_values_line_text_changed(new_text):
	variableMinValue = new_text
	update_variable_values()

func _on_max_values_line_text_changed(new_text):
	variableMaxValue = new_text
	update_variable_values()

func _on_quad_values_line_text_changed(new_text):
	variableQuadValues = new_text
	update_variable_values()
