extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 47
@export var nodeColorID = 0
var buttonToggled = false

#hkbGeneratorTransitionEffect Values
@export var nodeName = "GeneratorTransitionEffect"
@export var userData = 0
@export var selfTransitionMode = 3
@export var eventMode = 0
@export var blendInDuration = "0.25"
@export var blendOutDuration = "0.25"
@export var syncToGeneratorStartTime = false
@export var generatorChangedTransitionEffect = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	change_theme(nodeColorID)
	$Name.text = nodeName
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/userData/userDataButton.selected = userData
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/selfTransitionMode/SelfTransitionButton.selected = selfTransitionMode
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/eventMode/EventModeButton.selected = eventMode
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/blendInDuration/blendInDurationLine.text = blendInDuration
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/blendOutDuration/blendOutDurationLine.text = blendOutDuration
	if syncToGeneratorStartTime:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/syncToGeneratorStartTime/syncToGeneratorStartTimeButton.selected = 1


func _on_name_text_changed(new_text):
	nodeName = new_text

func _on_user_data_button_item_selected(index):
	userData = index

func _on_self_transition_button_item_selected(index):
	selfTransitionMode = index

func _on_event_mode_button_item_selected(index):
	eventMode = index

func _on_blend_in_duration_line_text_changed(new_text):
	blendInDuration = new_text

func _on_blend_out_duration_line_text_changed(new_text):
	blendOutDuration = new_text

func _on_sync_to_generator_start_time_button_item_selected(index):
	if index == 0:
		syncToGeneratorStartTime = false
	else:
		syncToGeneratorStartTime = true


# Pop-up Handler

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
	self.title = 'hkbGeneratorTransitionEffect - #' + str(nodeID)

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
	$DataPopupPanel/VBoxContainer/BaseNode/PinButton/PinIcon.visible = !buttonToggled
	$DataPopupPanel/VBoxContainer/BaseNode/PinButton/UnpinIcon.visible = buttonToggled
	$DataPopupPanel.popup_window = !buttonToggled

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
