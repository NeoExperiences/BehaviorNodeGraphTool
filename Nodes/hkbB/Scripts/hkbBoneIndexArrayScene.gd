extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 13
var buttonToggled = false

#hkbBoneIndexArray Values
@export var boneIndices = []
@onready var boneContainer = $DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/ScrollContainer/HBoxContainer/VBoxContainer
var bonepanel = load("res://Nodes/Children/boneIndexScene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	if len(boneIndices) != 0:
		for bone in boneIndices:
			_load_bones(bone)

func _on_gui_input(event):
	if event is InputEventMouseButton and event.double_click:
		show_popup()

func show_popup():
	$DataPopupPanel.popup()
	self.draggable = false

func _on_popup_panel_popup_hide():
	self.draggable = true
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
	self.title = 'hkbBoneIndexArray - #' + str(nodeID)

func _on_add_bones_pressed():
	var newBone = bonepanel.instantiate()
	boneContainer.add_child(newBone)

func _on_remove_bones_pressed():
	if boneContainer.get_child_count() > 0:
		var deletedBone = boneContainer.get_child(-1)
		boneContainer.remove_child(deletedBone)
		deletedBone.queue_free()
		_on_update_bone_array()

func _load_bones(boneIndex):
	var newBone = bonepanel.instantiate()
	newBone.boneIndex = boneIndex
	boneContainer.add_child(newBone)

func _on_update_bone_array():
	boneIndices = []
	for child in boneContainer.get_children():
		boneIndices.append(child.get("boneIndex"))


