extends OptionButton

var bufferSelection = 0

func _ready():
	_updateVariables()

func _updateVariables():
	bufferSelection = self.selected
	clear()
	add_item("null", 0)
	for variable in globalVariable.globalVariableList:
			add_item("#" + str(variable.get("variableID")) + " - " + variable.get("variableName"), variable.get("variableID"))
	self.selected = bufferSelection
