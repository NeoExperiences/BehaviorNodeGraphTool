extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 1
var buttonToggled = false
@export var nodeColorID = 0

#hkbBehaviorGraphScene Values
@export var nodeName = "RootBehavior.hkb"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Name.text = nodeName
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	change_theme(nodeColorID)

func _on_gui_input(event):
	if event is InputEventMouseButton and event.double_click:
		show_popup()

func show_popup():
	$DataPopupPanel.popup()
	self.draggable = false


func _on_data_popup_panel_popup_hide():
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
	parentGraph.get_parent().selected_nodes = []
	self.queue_free()

func _on_pin_button_toggled(toggled_on):
	buttonToggled = toggled_on
	$DataPopupPanel.popup_window = !buttonToggled

func _on_node_id_spin_box_value_changed(value):
	nodeID = value
	self.title = 'hkbBehaviorGraph - #' + str(nodeID)


func _on_line_edit_text_changed(new_text):
	nodeName = new_text


func _on_paint_button_pressed():
	nodeColorID += 1
	if nodeColorID > 11:
		nodeColorID = 0
	change_theme(nodeColorID)

func change_theme(index):
	match index:
		0:
			self.set_theme(globalVariable.defaultTheme)
		1:
			self.set_theme(globalVariable.redTheme)
		2:
			self.set_theme(globalVariable.orangeTheme)
		3:
			self.set_theme(globalVariable.yellowTheme)
		4:
			self.set_theme(globalVariable.brownTheme)
		5:
			self.set_theme(globalVariable.greenTheme)
		6:
			self.set_theme(globalVariable.emeraldTheme)
		7:
			self.set_theme(globalVariable.ceruleanTheme)
		8:
			self.set_theme(globalVariable.blueTheme)
		9:
			self.set_theme(globalVariable.deepBlueTheme)
		10:
			self.set_theme(globalVariable.purpleTheme)
		11:
			self.set_theme(globalVariable.eggplantTheme)


