extends OptionButton

func _ready():
	updateEventPayloads()

func updateEventPayloads():
	clear()
	add_item("null", 0)
	for payload in globalVariable.globalPayloadList:
			add_item("#" + str(payload.get("payloadID")) + " - " + payload.get("payloadName"), payload.get("payloadID"))
