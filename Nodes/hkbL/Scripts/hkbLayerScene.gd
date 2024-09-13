extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 50
@export var nodeColorID = 0
var buttonToggled = false

#hkbLayer Values
@export var weight = "1.0"
@export var worldFromModelWeight = "1.0"
@export var fadeInDuration = "0.0"
@export var fadeOutDuration = "0.0"
@export var onEventId = -1
@export var offEventId = -1
@export var onByDefault = true
@export var useMotion = false
@export var forceFullFadeDurations = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	change_theme(nodeColorID)
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/weight/weightLine.text = weight
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/worldFromModelWeight/worldFromModelWeightLine.text = worldFromModelWeight
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/fadeInDuration/fadeInDurationLine.text = fadeInDuration
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/fadeOutDuration/fadeOutDurationLine.text = fadeOutDuration
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/onEventId/onEventIdOptionButton._updateEvents()
	if onEventId == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/onEventId/onEventIdOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/onEventId/onEventIdOptionButton.selected = onEventId + 1
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/offEventId/offEventIdOptionButton._updateEvents()
	if offEventId == -1:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/offEventId/offEventIdOptionButton.selected = 0
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/offEventId/offEventIdOptionButton.selected = offEventId + 1
	if onByDefault:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/onByDefault/onByDefaultButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/onByDefault/onByDefaultButton.selected = 0
	if useMotion:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/useMotion/useMotionButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/useMotion/useMotionButton.selected = 0
	if forceFullFadeDurations:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/forceFullFadeDurations/forceFullFadeDurationsButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/forceFullFadeDurations/forceFullFadeDurationsButton.selected = 0

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
	self.title = 'hkbLayer - #' + str(nodeID)

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
			set_slot_color_left(0, Color(1,1,1,1))
			set_slot_color_right(0, Color(1,1,1,1))
			set_slot_color_right(1, Color(1,1,1,1))
			set_slot_color_right(2, Color(1,1,1,1))
			set_slot_color_right(3, Color(1,1,1,1))
			set_slot_color_right(4, Color(1,1,1,1))
			set_slot_color_right(5, Color(1,1,1,1))
		1:
			self.set_theme(globalVariable.redTheme)
			set_slot_color_left(0, Color(1,0.4,0.35,1))
			set_slot_color_right(0, Color(1,0.4,0.35,1))
			set_slot_color_right(1, Color(1,0.4,0.35,1))
			set_slot_color_right(2, Color(1,0.4,0.35,1))
			set_slot_color_right(3, Color(1,0.4,0.35,1))
			set_slot_color_right(4, Color(1,0.4,0.35,1))
			set_slot_color_right(5, Color(1,0.4,0.35,1))
		2:
			self.set_theme(globalVariable.orangeTheme)
			set_slot_color_left(0, Color(0.9,0.55,0.3,1))
			set_slot_color_right(1, Color(0.9,0.55,0.3,1))
			set_slot_color_right(2, Color(0.9,0.55,0.3,1))
			set_slot_color_right(3, Color(0.9,0.55,0.3,1))
			set_slot_color_right(4, Color(0.9,0.55,0.3,1))
			set_slot_color_right(5, Color(0.9,0.55,0.3,1))
			set_slot_color_right(6, Color(0.9,0.55,0.3,1))
		3:
			self.set_theme(globalVariable.yellowTheme)
			set_slot_color_left(0, Color(1,0.9,0.4,1))
			set_slot_color_right(1, Color(1,0.9,0.4,1))
			set_slot_color_right(2, Color(1,0.9,0.4,1))
			set_slot_color_right(3, Color(1,0.9,0.4,1))
			set_slot_color_right(4, Color(1,0.9,0.4,1))
			set_slot_color_right(5, Color(1,0.9,0.4,1))
			set_slot_color_right(6, Color(1,0.9,0.4,1))
		4:
			self.set_theme(globalVariable.brownTheme)
			set_slot_color_left(0, Color(0.7,0.6,0.5,1))
			set_slot_color_right(1, Color(0.7,0.6,0.5,1))
			set_slot_color_right(2, Color(0.7,0.6,0.5,1))
			set_slot_color_right(3, Color(0.7,0.6,0.5,1))
			set_slot_color_right(4, Color(0.7,0.6,0.5,1))
			set_slot_color_right(5, Color(0.7,0.6,0.5,1))
			set_slot_color_right(6, Color(0.7,0.6,0.5,1))
		5:
			self.set_theme(globalVariable.greenTheme)
			set_slot_color_left(0, Color(0.7,0.8,0.4,1))
			set_slot_color_right(1, Color(0.7,0.8,0.4,1))
			set_slot_color_right(2, Color(0.7,0.8,0.4,1))
			set_slot_color_right(3, Color(0.7,0.8,0.4,1))
			set_slot_color_right(4, Color(0.7,0.8,0.4,1))
			set_slot_color_right(5, Color(0.7,0.8,0.4,1))
			set_slot_color_right(6, Color(0.7,0.8,0.4,1))
		6:
			self.set_theme(globalVariable.emeraldTheme)
			set_slot_color_left(0, Color(0.5,0.8,0.5,1))
			set_slot_color_right(1, Color(0.5,0.8,0.5,1))
			set_slot_color_right(2, Color(0.5,0.8,0.5,1))
			set_slot_color_right(3, Color(0.5,0.8,0.5,1))
			set_slot_color_right(4, Color(0.5,0.8,0.5,1))
			set_slot_color_right(5, Color(0.5,0.8,0.5,1))
			set_slot_color_right(6, Color(0.5,0.8,0.5,1))
		7:
			self.set_theme(globalVariable.ceruleanTheme)
			set_slot_color_left(0, Color(0.4,0.7,0.7,1))
			set_slot_color_right(1, Color(0.4,0.7,0.7,1))
			set_slot_color_right(2, Color(0.4,0.7,0.7,1))
			set_slot_color_right(3, Color(0.4,0.7,0.7,1))
			set_slot_color_right(4, Color(0.4,0.7,0.7,1))
			set_slot_color_right(5, Color(0.4,0.7,0.7,1))
			set_slot_color_right(6, Color(0.4,0.7,0.7,1))
		8:
			self.set_theme(globalVariable.blueTheme)
			set_slot_color_left(0, Color(0.45,0.65,0.75,1))
			set_slot_color_right(1, Color(0.45,0.65,0.75,1))
			set_slot_color_right(2, Color(0.45,0.65,0.75,1))
			set_slot_color_right(3, Color(0.45,0.65,0.75,1))
			set_slot_color_right(4, Color(0.45,0.65,0.75,1))
			set_slot_color_right(5, Color(0.45,0.65,0.75,1))
			set_slot_color_right(6, Color(0.45,0.65,0.75,1))
		9:
			self.set_theme(globalVariable.deepBlueTheme)
			set_slot_color_left(0, Color(0.3,0.3,0.7,1))
			set_slot_color_right(1, Color(0.3,0.3,0.7,1))
			set_slot_color_right(2, Color(0.3,0.3,0.7,1))
			set_slot_color_right(3, Color(0.3,0.3,0.7,1))
			set_slot_color_right(4, Color(0.3,0.3,0.7,1))
			set_slot_color_right(5, Color(0.3,0.3,0.7,1))
			set_slot_color_right(6, Color(0.3,0.3,0.7,1))
		10:
			self.set_theme(globalVariable.purpleTheme)
			set_slot_color_left(0, Color(0.6,0.45,0.7,1))
			set_slot_color_right(1, Color(0.6,0.45,0.7,1))
			set_slot_color_right(2, Color(0.6,0.45,0.7,1))
			set_slot_color_right(3, Color(0.6,0.45,0.7,1))
			set_slot_color_right(4, Color(0.6,0.45,0.7,1))
			set_slot_color_right(5, Color(0.6,0.45,0.7,1))
			set_slot_color_right(6, Color(0.6,0.45,0.7,1))
		11:
			self.set_theme(globalVariable.eggplantTheme)
			set_slot_color_left(0, Color(0.7,0.4,0.6,1))
			set_slot_color_right(1, Color(0.7,0.4,0.6,1))
			set_slot_color_right(2, Color(0.7,0.4,0.6,1))
			set_slot_color_right(3, Color(0.7,0.4,0.6,1))
			set_slot_color_right(4, Color(0.7,0.4,0.6,1))
			set_slot_color_right(5, Color(0.7,0.4,0.6,1))
			set_slot_color_right(6, Color(0.7,0.4,0.6,1))

func _on_update_event_button_pressed():
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/onEventId/onEventIdOptionButton._updateEvents()
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/offEventId/offEventIdOptionButton._updateEvents()

func _on_weight_line_text_changed(new_text):
	weight = new_text

func _on_world_from_model_weight_line_text_changed(new_text):
	worldFromModelWeight = new_text

func _on_fade_in_duration_line_text_changed(new_text):
	fadeInDuration = new_text

func _on_fade_out_duration_line_text_changed(new_text):
	fadeOutDuration = new_text

func _on_on_event_id_option_button_item_selected(index):
	if index == 0:
		onEventId = -1
	else:
		onEventId = index - 1

func _on_off_event_id_option_button_item_selected(index):
	if index == 0:
		offEventId = -1
	else:
		offEventId = index - 1

func _on_on_by_default_button_item_selected(index):
	if index == 1:
		onByDefault = true
	else:
		onByDefault = false

func _on_use_motion_button_item_selected(index):
	if index == 1:
		useMotion = true
	else:
		useMotion = false

func _on_force_full_fade_durations_button_item_selected(index):
	if index == 1:
		forceFullFadeDurations = true
	else:
		forceFullFadeDurations = false
