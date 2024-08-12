extends Panel

var propertiesID = 0
var propertiesName = ""
var propertiesType = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$ValuesRowContainer/IDNumberContainer/IDNumberLabel.text = str(propertiesID)
	$ValuesRowContainer/NameContainer/NameLine.text = propertiesName
	$ValuesRowContainer/TypesContainer/TypesButton.selected = propertiesType

func update_property_values():
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()._on_update_properties_list()

func _on_name_line_text_changed(new_text):
	propertiesName = new_text
	update_property_values()

func _on_types_button_item_selected(index):
	propertiesType = index
	update_property_values()
