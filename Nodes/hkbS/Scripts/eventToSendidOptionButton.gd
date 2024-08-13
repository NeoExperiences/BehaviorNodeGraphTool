extends OptionButton

var bufferSelection = 0

func _ready():
	_updateEvents()

func _updateEvents():
	bufferSelection = self.selected
	clear()
	add_item("null", 0)
	for payload in globalVariable.globalEventList:
			add_item("#" + str(payload.get("eventID")) + " - " + payload.get("eventName"), payload.get("eventID"))
	self.selected = bufferSelection
