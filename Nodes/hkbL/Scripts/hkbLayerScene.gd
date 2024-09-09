extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 50
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
	self.queue_free()

func _on_pin_button_toggled(toggled_on):
	buttonToggled = toggled_on
	$DataPopupPanel.popup_window = !buttonToggled

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
