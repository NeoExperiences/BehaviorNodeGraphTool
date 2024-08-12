extends OptionButton

func _ready():
	_updatePayloads()

func _updatePayloads():
	clear()
	add_item("null", 0)
	for payload in globalVariable.globalPayloadList:
			add_item("#" + str(payload.get("payloadID")) + " - " + payload.get("payloadName"), payload.get("payloadID"))
