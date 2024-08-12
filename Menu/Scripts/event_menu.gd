extends Panel

#Variable Panel
var eventPanel = load("res://Menu/event_menu_row.tscn")
var eventIndexID = 0
@export var eventList = []
@onready var eventContainer = $VBoxContainer/PanelContainer2/ScrollContainer/HBoxContainer/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_update_event_list()

func _on_add_event_pressed():
	var newRow = eventPanel.instantiate()
	newRow.eventID = eventIndexID
	eventIndexID += 1
	eventContainer.add_child(newRow)
	_on_update_event_list()

func _on_update_event_list():
	eventList = []
	for child in eventContainer.get_children():
		var eventData = {
			"eventID": child.get("eventID"),
			"eventName": child.get("eventName"),
			"eventFlags": child.get("eventFlags")
		}
		eventList.append(eventData)
	get_parent().get_parent()._acquire_global_values()

func _on_remove_event_pressed():
	if eventContainer.get_child_count():
		var child = eventContainer.get_child(-1)
		eventContainer.remove_child(child)
		child.queue_free()
		eventIndexID -= 1
		_on_update_event_list()

func _clean_list():
	if eventContainer.get_child_count():
		for child in eventContainer.get_children():
			eventContainer.remove_child(child)
			child.queue_free()
		eventIndexID = 0
		_on_update_event_list()

func _load_global_values():
	var loadedEventList = globalVariable.globalEventList
	for event in loadedEventList:
		var loadedEvent = eventPanel.instantiate()
		loadedEvent.eventID = event.eventID
		loadedEvent.eventName = event.eventName
		loadedEvent.eventFlags = event.eventFlags
		eventIndexID += 1
		eventContainer.add_child(loadedEvent)
	for child in eventContainer.get_children():
		var eventData = {
			"eventID": child.get("eventID"),
			"eventName": child.get("eventName"),
			"eventFlags": child.get("eventFlags")
		}
		eventList.append(eventData)
