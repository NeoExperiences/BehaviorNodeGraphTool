extends PanelContainer

# Transition Variables
var transitionIndex = 0
var eventId = 0
var toStateId = 0
var fromNestedStateId = 0
var toNestedStateId = 0
var priority = 0
#var flags = "0"
var flags = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
var transition = 1
var triggerInterval = [-1, -1, 0.0, 0.0]
var initiateInterval = [-1, -1, 0.0, 0.0]
@onready var flagsPopUp = $transitionContainer/dataContainer/Flags/FlagsPopupMenu


func _ready():
	$transitionContainer/dataContainer/eventId/eventIdSpinBox.value = eventId
	$transitionContainer/dataContainer/toStateId/toStateIdSpinBox.value = toStateId
	$transitionContainer/dataContainer/fromNestedStateID/fromNestedStateIDSpinBox.value = fromNestedStateId
	$transitionContainer/dataContainer/toNestedStateId/toNestedStateIdSpinBox.value = toNestedStateId
	$transitionContainer/dataContainer/priority/prioritySpinBox.value = priority
	for index in range(len(flags)):
		flagsPopUp.set_item_checked(index, flags[index])
	$transitionContainer/dataContainer/transition/transitionButton.selected = transition

func _update_name():
	$transitionContainer/PanelContainer/TransitionNameLabel.text = "Transition #" + str(transitionIndex)

func _on_event_id_spin_box_value_changed(value):
	eventId = value
	_updated_values()

func _on_to_state_id_spin_box_value_changed(value):
	toStateId = value
	_updated_values()

func _on_from_nested_state_id_spin_box_value_changed(value):
	fromNestedStateId = value
	_updated_values()

func _on_to_nested_state_id_spin_box_value_changed(value):
	toNestedStateId = value
	_updated_values()

func _on_priority_spin_box_value_changed(value):
	priority = value
	_updated_values()

#func _on_transition_button_pressed():
	#get_parent().get_parent().get_parent().get_parent()._acquire_global_values()
	#$transitionContainer/dataContainer/transition/transitionButton.updateTransitions()

func _update_transitions():
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()._acquire_global_values()
	$transitionContainer/dataContainer/transition/transitionButton.updateTransitions()

func _on_transition_button_item_selected(index):
	transition = index
	_updated_values()

func _updated_values():
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()._on_update_transition_array()

func _on_show_button_pressed():
	if !$transitionContainer/dataContainer.visible:
		$transitionContainer/dataContainer.visible = 1
		$transitionContainer/ShowButton.text = "Hide Data"
	else:
		$transitionContainer/dataContainer.visible = 0
		$transitionContainer/ShowButton.text = "Show Data"
	get_parent().get_parent().reset_size()


func _on_flags_popup_button_pressed():
	flagsPopUp.show()


func _on_flags_popup_menu_index_pressed(index):
	flagsPopUp.set_item_checked(index, !flagsPopUp.is_item_checked(index))
	flags[index] = flagsPopUp.is_item_checked(index)

#func _on_flags_popup_menu_index_pressed(index):
	#flags = ""
	#flagsPopUp.set_item_checked(index, !flagsPopUp.is_item_checked(index))
	#
	#for popUpIndex in range(flagsPopUp.item_count):
		#if flagsPopUp.is_item_checked(popUpIndex):
			#match popUpIndex:
				#0:
					#if flags == "":
						#flags += "FLAG_USE_TRIGGER_INTERVAL"
					#else:
						#flags += "|FLAG_USE_TRIGGER_INTERVAL"
				#1:
					#if flags == "":
						#flags += "FLAG_USE_INITIATE_INTERVAL"
					#else:
						#flags += "|FLAG_USE_INITIATE_INTERVAL"
				#2:
					#if flags == "":
						#flags += "FLAG_UNINTERRUPTIBLE_WHILE_PLAYING"
					#else:
						#flags += "|FLAG_UNINTERRUPTIBLE_WHILE_PLAYING"
				#3:
					#if flags == "":
						#flags += "FLAG_UNINTERRUPTIBLE_WHILE_DELAYED"
					#else:
						#flags += "|FLAG_UNINTERRUPTIBLE_WHILE_DELAYED"
				#4:
					#if flags == "":
						#flags += "FLAG_DELAY_STATE_CHANGE"
					#else:
						#flags += "|FLAG_DELAY_STATE_CHANGE"
				#5:
					#if flags == "":
						#flags += "FLAG_DISABLED"
					#else:
						#flags += "|FLAG_DISABLED"
				#6:
					#if flags == "":
						#flags += "FLAG_DISALLOW_RETURN_TO_PREVIOUS_STATE"
					#else:
						#flags += "|FLAG_DISALLOW_RETURN_TO_PREVIOUS_STATE"
				#7:
					#if flags == "":
						#flags += "FLAG_DISALLOW_RANDOM_TRANSITION"
					#else:
						#flags += "|FLAG_DISALLOW_RANDOM_TRANSITION"
				#8:
					#if flags == "":
						#flags += "FLAG_DISABLE_CONDITION"
					#else:
						#flags += "|FLAG_DISABLE_CONDITION"
				#9:
					#if flags == "":
						#flags += "FLAG_ALLOW_SELF_TRANSITION_BY_TRANSITION_FROM_ANY_STATE"
					#else:
						#flags += "|FLAG_ALLOW_SELF_TRANSITION_BY_TRANSITION_FROM_ANY_STATE"
				#10:
					#if flags == "":
						#flags += "FLAG_IS_GLOBAL_WILDCARD"
					#else:
						#flags += "|FLAG_IS_GLOBAL_WILDCARD"
				#11:
					#if flags == "":
						#flags += "FLAG_IS_LOCAL_WILDCARD"
					#else:
						#flags += "|FLAG_IS_LOCAL_WILDCARD"
				#12:
					#if flags == "":
						#flags += "FLAG_FROM_NESTED_STATE_ID_IS_VALID"
					#else:
						#flags += "|FLAG_FROM_NESTED_STATE_ID_IS_VALID"
				#13:
					#if flags == "":
						#flags += "FLAG_TO_NESTED_STATE_ID_IS_VALID"
					#else:
						#flags += "|FLAG_TO_NESTED_STATE_ID_IS_VALID"
				#14:
					#if flags == "":
						#flags += "FLAG_ABUT_AT_END_OF_FROM_GENERATOR"
					#else:
						#flags += "|FLAG_ABUT_AT_END_OF_FROM_GENERATOR"
	#if flags == "":
		#flags = "0"
	#_updated_values()

