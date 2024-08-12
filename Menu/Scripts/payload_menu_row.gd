extends Panel

var payloadID = 5000
var payloadName = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$ValuesRowContainer/IDNumberContainer/IDNumberLabel.text = str(payloadID)
	$ValuesRowContainer/NameContainer/NameLine.text = payloadName

func update_payload_values():
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()._on_update_payload_list()

func _on_name_line_text_changed(new_text):
	payloadName = new_text
	update_payload_values()
