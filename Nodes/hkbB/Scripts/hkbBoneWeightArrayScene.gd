extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 14
var buttonToggled = false

#hkbBoneWeightArray Values
@export var boneWeights = []
@onready var boneWeightContainer = $DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer
var boneweightpanel = load("res://Nodes/Children/boneWeightsScene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	if len(boneWeights) != 0:
		for boneWeight in boneWeights:
			_load_bones(boneWeight)

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
	self.queue_free()

func _on_pin_button_toggled(toggled_on):
	buttonToggled = toggled_on
	$DataPopupPanel.popup_window = !buttonToggled

func _on_node_id_spin_box_value_changed(value):
	nodeID = value
	self.title = 'hkbBoneWeightArray - #' + str(nodeID)

func _on_add_bones_pressed():
	var newBoneWeight = boneweightpanel.instantiate()
	boneWeightContainer.add_child(newBoneWeight)

func _on_remove_bones_pressed():
	if boneWeightContainer.get_child_count() > 0:
		var deletedBoneWeight = boneWeightContainer.get_child(-1)
		boneWeightContainer.remove_child(deletedBoneWeight)
		deletedBoneWeight.queue_free()
		_on_update_bone_weight_array()

func _load_bones(boneWeight):
	var newBoneWeight = boneweightpanel.instantiate()
	newBoneWeight.boneWeight = boneWeight
	boneWeightContainer.add_child(newBoneWeight)

func _on_update_bone_weight_array():
	boneWeights = []
	for child in boneWeightContainer.get_children():
		boneWeights.append(child.get("boneWeight"))
