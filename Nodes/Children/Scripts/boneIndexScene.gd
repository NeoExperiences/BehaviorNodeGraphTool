extends PanelContainer

# Bone Index Variable
var boneIndex = 0

func _ready():
	$boneIndexContainer/dataContainer/boneIndex/boneIndexSpinBox.value = boneIndex

func update_values():
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()._on_update_bone_array()

func _on_bone_index_spin_box_value_changed(value):
	boneIndex = value
	update_values()
