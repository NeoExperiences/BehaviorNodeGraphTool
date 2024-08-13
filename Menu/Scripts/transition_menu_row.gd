extends Panel

var transitionID = 0
var transitionName = ""
var transitionVariableBindingSet = 0
var transitionSelfTransitionMode = 0
var transitionEventMode = 0
var transitionDuration = "0.0"
var transitionToGeneratorStartTimeFraction = "0.0"
var transitionFlags = 0
var transitionEndMode = 0
var transitionBlendCurve = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$ValuesRowContainer/IDNumberContainer/IDNumberLabel.text = str(transitionID)
	$ValuesRowContainer/NameContainer/NameLine.text = transitionName
	$ValuesRowContainer/VariableBindingSetContainer/VariableBindingSetLine.text = str(transitionVariableBindingSet)
	$ValuesRowContainer/SelfTransitionContainer/SelfTransitionButton.selected = transitionSelfTransitionMode
	$ValuesRowContainer/EventModeContainer/EventModeButton.selected = transitionEventMode
	$ValuesRowContainer/DurationContainer/DurationLine.text = transitionDuration
	$ValuesRowContainer/ToGeneratorStartContainer/ToGeneratorStartLine.text = transitionToGeneratorStartTimeFraction
	$ValuesRowContainer/FlagsContainer/FlagsButton.selected = transitionFlags
	$ValuesRowContainer/EndModeContainer/EndModeButton.selected = transitionEndMode
	$ValuesRowContainer/BlendCurveContainer/BlendCurveButton.selected = transitionBlendCurve 

func update_transition_values():
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()._on_update_transition_list()

func _on_name_line_text_changed(new_text):
	transitionName = new_text
	update_transition_values()

func _on_variable_binding_set_line_text_changed(new_text):
	transitionVariableBindingSet = new_text
	update_transition_values()

func _on_self_transition_button_item_selected(index):
	transitionSelfTransitionMode = index
	update_transition_values()

func _on_event_mode_button_item_selected(index):
	transitionEventMode = index
	update_transition_values()

func _on_duration_line_text_changed(new_text):
	transitionDuration = new_text
	update_transition_values()

func _on_to_generator_start_line_text_changed(new_text):
	transitionToGeneratorStartTimeFraction = new_text
	update_transition_values()

func _on_flags_button_item_selected(index):
	transitionFlags = index
	update_transition_values()

func _on_end_mode_button_item_selected(index):
	transitionEndMode = index
	update_transition_values()

func _on_blend_curve_button_item_selected(index):
	transitionBlendCurve = index
	update_transition_values()


