extends OptionButton

var bufferSelection = 0

func _ready():
	_updateEventPayloads()

func _updateEventPayloads():
	bufferSelection = self.selected
	clear()
	add_item("null", 0)
	for payload in globalVariable.globalPayloadList:
			add_item("#" + str(payload.get("payloadID")) + " - " + payload.get("payloadName"), payload.get("payloadID"))
	self.selected = bufferSelection
