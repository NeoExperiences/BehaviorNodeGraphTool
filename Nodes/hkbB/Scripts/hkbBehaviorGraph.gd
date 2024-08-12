extends GraphNode

#Base Node Values
@export var nodeID = 0
@export var nodeTypeID = 1

#hkbBehaviorGraphScene Values
@export var nodeName = "RootBehavior.hkb"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Name.text = nodeName


func _on_line_edit_text_changed(new_text):
	nodeName = new_text

