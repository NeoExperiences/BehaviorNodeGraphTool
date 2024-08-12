extends PanelContainer

# Bone Index Variable
var boneWeight = "0.0"

func _ready():
	$boneWeightContainer/dataContainer/boneWeight/boneWeightLine.text = boneWeight

func update_values():
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()._on_update_bone_weight_array()

func _on_bone_weight_line_text_changed(new_text):
	boneWeight = new_text
	update_values()
