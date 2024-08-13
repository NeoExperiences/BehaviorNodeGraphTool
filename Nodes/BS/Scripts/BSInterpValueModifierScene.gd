extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 34
var buttonToggled = false

#BSInterpValueModifier Values
@export var nodeName = "InterpValueModifier"
@export var userData = 0
@export var enable = true
@export var source = "0.0"
@export var target = "1.0"
@export var result = "0.0"
@export var gain = "1.0"

# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	$Name.text = nodeName
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/userData/userDataButton.selected = userData
	if enable:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enable/enableButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enable/enableButton.selected = 0
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/source/sourceLine.text = source
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/target/targetLine.text = target
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/result/resultLine.text = result
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/gain/gainLine.text = gain

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

func _on_node_id_spin_box_value_changed(value):
	nodeID = value
	self.title = 'BSInterpValueModifier - #' + str(nodeID)

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

func _on_enable_button_item_selected(index):
	if index == 1:
		enable = true
	else:
		enable = false

func _on_source_line_text_changed(new_text):
	source = new_text


func _on_target_line_text_changed(new_text):
	target = new_text


func _on_result_line_text_changed(new_text):
	result = new_text


func _on_gain_line_text_changed(new_text):
	gain = new_text