extends OptionButton


func _ready():
	updateEvents()

func updateEvents():
	clear()
	add_item("null", 0)
	if globalVariable.globalEventList.size() != 0:
		for event in globalVariable.globalEventList:
				add_item("#" + str(event.get("eventID")) + " - " + event.get("eventName"), event.get("eventID"))
