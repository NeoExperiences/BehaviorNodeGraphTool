extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 23
var buttonToggled = false

#hkbBlenderGenerator Values
@export var nodeName = "BlenderGenerator"
@export var userData = 0
@export var blendParameter = "0.0"
@export var maxCyclicBlendParameter = "1.0"
@export var indexOfSyncMasterChild = 65535
@export var flagsIndex = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	$Name.text = nodeName
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/userData/userDataButton.selected = userData
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/blendParameter/blendParameterLine.text = blendParameter
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/maxCyclicBlendParameter/maxCyclicBlendParameterLine.text = maxCyclicBlendParameter
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/indexOfSyncMasterChild/indexOfSyncMasterChildSpinBox.value = indexOfSyncMasterChild
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/flags/flagsSpinBox.value = flagsIndex
	

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

func _on_node_id_spin_box_value_changed(value):
	nodeID = value
	self.title = 'hkbBlenderGenerator - #' + str(nodeID)

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

func _on_name_text_changed(new_text):
	nodeName = new_text

func _on_user_data_button_item_selected(index):
	userData = index

func _on_blend_parameter_line_text_changed(new_text):
	blendParameter = new_text

func _on_max_cyclic_blend_parameter_line_text_changed(new_text):
	maxCyclicBlendParameter = new_text

func _on_index_of_sync_master_child_spin_box_value_changed(value):
	indexOfSyncMasterChild = value

func _on_flags_spin_box_value_changed(value):
	flagsIndex = value
