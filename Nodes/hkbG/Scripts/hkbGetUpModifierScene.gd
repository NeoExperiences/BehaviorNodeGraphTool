extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 11
@export var nodeColorID = 0
var buttonToggled = false

#hkbModifierGenerator Values
@export var nodeName = "GetUpModifier"
@export var userData = 0
@export var enable = true
@export var groundNormal = "(0.0 0.0 0.0 0.0)"
@export var duration = "1.0"
@export var alignWithGroundDuration = "0.25"
@export var rootBoneIndex = 0
@export var otherBoneIndex = 0
@export var anotherBoneIndex = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$DataPopupPanel/VBoxContainer/BaseNode/nodeIDSpinBox.value = nodeID
	change_theme(nodeColorID)
	$Name.text = nodeName
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/userData/userDataButton.selected = userData
	if enable:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enable/enableButton.selected = 1
	else:
		$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/enable/enableButton.selected = 0
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/groundNormal/groundNormalLine.text = groundNormal
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/duration/durationLine.text = duration
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/alignGroundDuration/alignWithGroundDurationLine.text = alignWithGroundDuration
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/rootBoneIndex/rootBoneIndexSpinBox.value = rootBoneIndex
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/otherBoneIndex/otherBoneIndexSpinBox.value = otherBoneIndex
	$DataPopupPanel/VBoxContainer/PanelContainer/FoldingPanel/anotherBoneIndex/anotherBoneIndexSpinBox.value = anotherBoneIndex




func _on_gui_input(event):
	if event is InputEventMouseButton and event.double_click:
		show_popup()

func show_popup():
	#var screen_size = get_viewport().size
	#var popup_size = $PopupMenu.get_size()
	#$PopupMenu.set_position(get_global_position() + Vector2(200, 000))
	#var popup_position = $PopupMenu.get_position()
	#if popup_position.x + popup_size.x > screen_size.x:
		#popup_position.x = screen_size.x - popup_size.x
	#if popup_position.y + popup_size.y > screen_size.y:
		#popup_position.y = screen_size.y - popup_size.y
	#if popup_position.x < 0:
		#popup_position.x = 0
	#if popup_position.y < 0:
		#popup_position.y = 0
	$DataPopupPanel.popup()
	self.draggable = false

func _on_popup_panel_popup_hide():
	self.draggable = true
	self.selected = false
	$DataPopupPanel/VBoxContainer/BaseNode/DeleteButton.show()
	$DataPopupPanel/VBoxContainer/BaseNode/ConfirmDeleteButton.hide()

func _on_node_id_spin_box_value_changed(value):
	nodeID = value
	self.title = 'hkbGetUpModifier - #' + str(nodeID)

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

func _on_name_text_changed(new_text):
	nodeName = new_text

func _on_user_data_button_item_selected(index):
	userData = index

func _on_another_bone_index_spin_box_value_changed(value):
	anotherBoneIndex = value

func _on_align_with_ground_duration_line_text_changed(new_text):
	alignWithGroundDuration = new_text

func _on_root_bone_index_spin_box_value_changed(value):
	rootBoneIndex = value

func _on_other_bone_index_spin_box_value_changed(value):
	otherBoneIndex = value

func _on_duration_line_text_changed(new_text):
	duration = new_text

func _on_ground_normal_line_text_changed(new_text):
	groundNormal = new_text

func _on_enable_button_item_selected(index):
	if index == 1:
		enable = true
	else:
		enable = false
