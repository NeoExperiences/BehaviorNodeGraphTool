extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 24
var buttonToggled = false

#hkbBlenderGeneratorChild Values
@export var nodeName = "BlenderGeneratorChild"
@export var weight = "1.0"
@export var worldFromModelWeight = "1.0"

# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/weight/weightLine.text = weight
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/worldFromModelWeight/worldFromModelWeightLine.text = worldFromModelWeight

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
	self.title = 'hkbBlenderGeneratorChild - #' + str(nodeID)

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

func _on_weight_line_text_changed(new_text):
	weight = new_text

func _on_world_from_model_weight_line_text_changed(new_text):
	worldFromModelWeight = new_text
