extends Panel

var eventID = 0
var eventName = ""
var eventFlags = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$ValuesRowContainer/IDNumberContainer/IDNumberLabel.text = str(eventID)
	$ValuesRowContainer/NameContainer/NameLine.text = eventName
	$ValuesRowContainer/TypesContainer/TypesButton.selected = eventFlags

func update_variable_values():
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()._on_update_event_list()

func _on_name_line_text_changed(new_text):
	eventName = new_text
	update_variable_values()

func _on_types_button_item_selected(index):
	eventFlags = index
	update_variable_values()


