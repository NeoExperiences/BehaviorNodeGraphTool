extends Panel

var payloadPanel = load("res://Menu/payload_menu_row.tscn")
var payloadIndexID = 1
@export var payloadList = []
@onready var payloadContainer = $VBoxContainer/PanelContainer2/ScrollContainer/HBoxContainer/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_update_payload_list()

func _on_add_payload_pressed():
	var newRow = payloadPanel.instantiate()
	newRow.payloadID = payloadIndexID
	payloadContainer.add_child(newRow)
	payloadIndexID += 1
	_on_update_payload_list()

func _on_update_payload_list():
	payloadList = []
	for child in payloadContainer.get_children():
		var payloadData = {
			"payloadID": child.get("payloadID"),
			"payloadName": child.get("payloadName"),
		}
		payloadList.append(payloadData)
	get_parent().get_parent()._acquire_global_values()

func _on_remove_payload_pressed():
	if payloadContainer.get_child_count():
		var child = payloadContainer.get_child(-1)
		payloadContainer.remove_child(child)
		child.queue_free()
		payloadIndexID -= 1
		_on_update_payload_list()

func _clean_list():
	if payloadContainer.get_child_count():
		for child in payloadContainer.get_children():
			payloadContainer.remove_child(child)
			child.queue_free()
		payloadIndexID = 1
		_on_update_payload_list()

func _load_global_values():
	var loadedPayloadList = globalVariable.globalPayloadList
	for payload in loadedPayloadList:
		var loadedPayload = payloadPanel.instantiate()
		loadedPayload.payloadID = payload.payloadID
		loadedPayload.payloadName = payload.payloadName
		payloadIndexID += 1
		payloadContainer.add_child(loadedPayload)
	for child in payloadContainer.get_children():
		var payloadData = {
			"payloadID": child.get("payloadID"),
			"payloadName": child.get("payloadName"),
		}
		payloadList.append(payloadData)
