extends OptionButton


# Called when the node enters the scene tree for the first time.
func _ready():
	updateTransitions()

func updateTransitions():
	clear()
	add_item("null", 0)
	for transition in globalVariable.globalTransitionList:
			add_item("#" + str(transition.get("transitionID")) + " - " + transition.get("transitionName"), transition.get("transitionID"))