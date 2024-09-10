extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 21
@export var nodeColorID = 0
var buttonToggled = false

#hkbExpressionDataArray Values
var expressionpanel = load("res://Nodes/Children/ExpressionScene.tscn")
var expressionIndex = 0
@export var expressionArray = []
@onready var expressionContainer = $DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	change_theme(nodeColorID)
	if expressionArray:
		for expression in expressionArray:
			_load_expressions(expression.expression, expression.assignmentVariableIndex, expression.assignmentEventIndex)
	else:
		_on_add_expression_pressed()
		_on_update_expression_array()

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
	self.title = 'hkbExpressionDataArray - #' + str(nodeID)

func _on_add_expression_pressed():
	expressionIndex += 1
	var newExpression = expressionpanel.instantiate()
	newExpression.expressionIndex = expressionIndex
	expressionContainer.add_child(newExpression)
	_on_update_expression_array()

func _on_remove_expression_pressed():
	if expressionContainer.get_child_count() > 1:
		var deletedExpression = expressionContainer.get_child(-1)
		expressionContainer.remove_child(deletedExpression)
		deletedExpression.queue_free()
		expressionIndex -= 1
		_on_update_expression_array()
		reset_size()

func _on_update_expression_array():
	expressionArray = []
	for child in expressionContainer.get_children():
		if child.get_name() != "ButtonContainer" && child.get_name() != "indexOfExpressionToEnable":
			var expressionData = {
				"expression": child.get("expression"),
				"assignmentVariableIndex": child.get("assignmentVariableIndex"),
				"assignmentEventIndex": child.get("assignmentEventIndex"),
			}
			expressionArray.append(expressionData)

func _load_expressions(expression, assignmentVariableIndex, assignmentEventIndex):
	expressionIndex += 1
	var newExpression = expressionpanel.instantiate()
	newExpression.expressionIndex = expressionIndex
	newExpression.expression = expression
	newExpression.assignmentVariableIndex = assignmentVariableIndex
	newExpression.assignmentEventIndex = assignmentEventIndex
	expressionContainer.add_child(newExpression)
