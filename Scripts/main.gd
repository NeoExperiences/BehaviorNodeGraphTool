extends Control

# Graph Variables
var nodeIndex = 90
var nodeInfo: Array = []
var connectionInfo: Array = []
var selected_nodes: Array = []
var node_buffer: Array = []

# Behavior Parser Script
var behaviorParserScript = preload("res://Scripts/behavior_parser.gd").new()

# File Management Script
var fileManagementScript = preload("res://Scripts/file_management.gd").new()

# XML Import Script
var xmlImportScript = preload("res://Scripts/xml_import.gd").new()

# Context Menu
@onready var contextMenu		= $ContextMenu
@onready var createNodeMenuList = $CreateNodeMenu/CreateNodeMenuList
@onready var createNodeMenuBS	= $CreateNodeMenu/CreateNodeMenuBS
@onready var createNodeMenuhkbB = $CreateNodeMenu/CreateNodeMenuhkbB
@onready var createNodeMenuhkbC = $CreateNodeMenu/CreateNodeMenuhkbC
@onready var createNodeMenuhkbE = $CreateNodeMenu/CreateNodeMenuhkbE
@onready var createNodeMenuhkbG = $CreateNodeMenu/CreateNodeMenuhkbG
@onready var createNodeMenuhkbM = $CreateNodeMenu/CreateNodeMenuhkbM
@onready var createNodeMenuhkbP = $CreateNodeMenu/CreateNodeMenuhkbP
@onready var createNodeMenuhkbS = $CreateNodeMenu/CreateNodeMenuhkbS
@onready var createNodeMenuhkbR = $CreateNodeMenu/CreateNodeMenuhkbR
@onready var createNodeMenuhkbT = $CreateNodeMenu/CreateNodeMenuhkbT

# Graph Data Menus
@onready var variableMenu		= $GraphMenu/VariableMenu
@onready var eventMenu			= $GraphMenu/EventMenu
@onready var transitionMenu		= $GraphMenu/TransitionMenu
@onready var propertiesMenu		= $GraphMenu/PropertiesMenu
@onready var eventPayloadsMenu	= $GraphMenu/PayloadsMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_instance()

#Node Instancing Code
func instance_node(scene):
	var node = scene.instantiate()
	var nodeIndexLast = 91
	for child in $GraphEdit.get_children():
		if child.get("nodeID") > nodeIndexLast:
			nodeIndexLast = child.get("nodeID")
	node.position_offset = ((Vector2($GraphEdit.get_size().x / 2,$GraphEdit.get_size().y / 2) + $GraphEdit.scroll_offset) - Vector2(150, 150)) / $GraphEdit.zoom
	node.title += ' - #' + str(nodeIndexLast + 1)
	node.nodeID = nodeIndexLast + 1
	$GraphEdit.add_child(node)
	nodeIndex = nodeIndexLast + 1

#Node Instancing Code
func initial_instance():
	var NodeRoot = globalVariable.hkRootLevelContainer.instantiate()
	NodeRoot.title += ' - #' + str(nodeIndex)
	NodeRoot.nodeID = nodeIndex
	NodeRoot.position_offset = Vector2(0, 60)
	$GraphEdit.add_child(NodeRoot)
	nodeIndex += 1
	var NodeGraph = globalVariable.hkbBehaviorGraph.instantiate()
	NodeGraph.title += ' - #' + str(nodeIndex)
	NodeGraph.nodeID = nodeIndex
	NodeGraph.position_offset = Vector2(300, 20)
	$GraphEdit.add_child(NodeGraph)
	nodeIndex += 1
	$GraphEdit.connect_node(str(NodeRoot.name), 0, str(NodeGraph.name), 0)
	var StateMachine = globalVariable.hkbStateMachine.instantiate()
	StateMachine.title += ' - #' + str(nodeIndex)
	StateMachine.nodeID = nodeIndex
	StateMachine.position_offset = Vector2(640, 0)
	$GraphEdit.add_child(StateMachine)
	nodeIndex += 1
	$GraphEdit.connect_node(str(NodeGraph.name), 0, str(StateMachine.name), 0)
	_process_connections()

# Node Creation Menus
func _on_create_node_button_pressed():
	createNodeMenuList.show()

func _on_create_node_menu_list_id_pressed(id):
	match id:
		0: # BGSGamebryoSequenceGenerator
			instance_node(globalVariable.BGSGamebryoSequenceGenerator)
		1: # 
			createNodeMenuBS.show()
		2: # DynamicAnimationTaggingGenerator
			instance_node(globalVariable.DynamicAnimationTaggingGenerator)
		3: # 
			createNodeMenuhkbB.show()
		4: # 
			createNodeMenuhkbC.show()
		5: # hkbDampingModifier
			instance_node(globalVariable.hkbDampingModifier)
		6: # 
			createNodeMenuhkbE.show()
		7: # hkbGetUpModifier
			createNodeMenuhkbG.show()
		8: # hkbKeyframeBonesModifier
			instance_node(globalVariable.hkbKeyframeBonesModifier)
		9: # 
			createNodeMenuhkbM.show()
		10: # 
			createNodeMenuhkbP.show()
		11: # 
			createNodeMenuhkbR.show()
		12: # 
			createNodeMenuhkbS.show()
		13: # 
			createNodeMenuhkbT.show()
		14: # hkbVariableBindingSet
			instance_node(globalVariable.hkbVariableBindingSet)

func _on_create_node_menu_bs_id_pressed(id):
	match id:
		0: # BSAssignVariablesModifier
			instance_node(globalVariable.BSAssignVariablesModifier)
		1: # BSBehaviorGraphSwapGenerator
			instance_node(globalVariable.BSBehaviorGraphSwapGenerator)
		2: # BSCyclicBlendTransitionGenerator
			instance_node(globalVariable.BSCyclicBlendTransitionGenerator)
		3: # BSGetTimeStepModifier
			instance_node(globalVariable.BSGetTimeStepModifier)
		4: # BSInterpValueModifier
			instance_node(globalVariable.BSInterpValueModifier)
		5: # BSIsActiveModifier
			instance_node(globalVariable.BSIsActiveModifier)
		6: # BSLookAtModifier
			print("BSLookAtModifier is not supported yet.")
		7: # BSModifyOnceModifier
			instance_node(globalVariable.BSModifyOnceModifier)
		8: # BSRagdollContactListenerModifier
			print("BSRagdollContactListenerModifier is not supported yet.")
		9: # BSTimerModifier
			instance_node(globalVariable.BSTimerModifier)

func _on_create_node_menuhkb_b_id_pressed(id):
	match id:
		0: # hkbBehaviorReferenceGenerator
			instance_node(globalVariable.hkbBehaviorReferenceGenerator)
		1: # hkbBlenderGenerator
			instance_node(globalVariable.hkbBlenderGenerator)
		2: # hkbBlenderGeneratorChild
			instance_node(globalVariable.hkbBlenderGeneratorChild)
		3: # hkbBoneIndexArray
			instance_node(globalVariable.hkbBoneIndexArray)
		4: # hkbBoneWeightArray
			instance_node(globalVariable.hkbBoneWeightArray)

func _on_create_node_menuhkb_c_id_pressed(id):
	match id:
		0: # hkbClipGenerator
			instance_node(globalVariable.hkbClipGenerator)
		1: # hkbClipTriggerArray
			instance_node(globalVariable.hkbClipTriggerArray)

func _on_create_node_menuhkb_e_id_pressed(id):
	match id:
		0: # hkbEvaluateExpressionModifier
			instance_node(globalVariable.hkbEvaluateExpressionModifier)
		1: # hkbEventDrivenModifier
			instance_node(globalVariable.hkbEventDrivenModifier)
		2: # hkbEventRangeDataArray
			instance_node(globalVariable.hkbEventRangeDataArray)
		3: # hkbEventsFromRangeModifier
			instance_node(globalVariable.hkbEventsFromRangeModifier)
		4: # hkbExpressionDataArray
			instance_node(globalVariable.hkbExpressionDataArray)

func _on_create_node_menuhkb_g_id_pressed(id):
	match id:
		0: # hkbGeneratorTransitionEffect
			instance_node(globalVariable.hkbGeneratorTransitionEffect)
		1: # hkbGetUpModifier
			instance_node(globalVariable.hkbGetUpModifier)

func _on_create_node_menuhkb_m_id_pressed(id):
	match id:
		0: # hkbManualSelectorGenerator
			instance_node(globalVariable.hkbManualSelectorGenerator)
		1: # hkbModifierGenerator
			instance_node(globalVariable.hkbModifierGenerator)
		2: # hkbModifierList
			instance_node(globalVariable.hkbModifierList)

func _on_create_node_menuhkb_p_id_pressed(id):
	match id:
		0: # hkbPoseMatchingGenerator
			instance_node(globalVariable.hkbPoseMatchingGenerator)
		1: # hkbPoweredRagdollControlsModifier
			instance_node(globalVariable.hkbPoweredRagdollControlsModifier)

func _on_create_node_menuhkb_s_id_pressed(id):
	match id:
		0: # hkbStateMachine
			instance_node(globalVariable.hkbStateMachine)
		1: # hkbStateMachineEventPropertyArray
			instance_node(globalVariable.hkbStateMachineEventPropertyArray)
		2: # hkbStateMachineStateInfo
			instance_node(globalVariable.hkbStateMachineStateInfo)
		3: # hkbStateMachineTransitionInfoArray
			instance_node(globalVariable.hkbStateMachineTransitionInfoArray)

func _on_create_node_menuhkb_r_id_pressed(id):
	match id:
		0: # hkbReferencePoseGenerator
			instance_node(globalVariable.hkbReferencePoseGenerator)
		1: # hkbRigidBodyRagdollControlsModifier
			instance_node(globalVariable.hkbRigidBodyRagdollControlsModifier)

func _on_create_node_menuhkb_t_id_pressed(id):
	match id:
		0: # hkbTimerModifier
			instance_node(globalVariable.hkbTimerModifier)
		1: # hkbTwistModifier
			instance_node(globalVariable.hkbTwistModifier)

# Graph Node Connections
func _on_graph_edit_connection_request(from_node, from_port, to_node, to_port):
	$GraphEdit.connect_node(from_node, from_port, to_node, to_port)
	_process_connections()

func _on_graph_edit_disconnection_request(from_node, from_port, to_node, to_port):
	$GraphEdit.disconnect_node(from_node, from_port, to_node, to_port)
	_process_connections()

func _process_connections():
	connectionInfo = []
	for connection in $GraphEdit.get_connection_list():
		var from_path := NodePath(connection["from_node"])
		var to_path := NodePath(connection["to_node"])
		var connectionData = [(connection["from_port"]),$GraphEdit.get_node(from_path).get("nodeID"),$GraphEdit.get_node(to_path).get("nodeID")]
		connectionInfo.append(connectionData)


# Graph Node Operations

func _on_graph_edit_node_selected(node):
	if node not in selected_nodes:
		selected_nodes.append(node)

func _on_graph_edit_node_deselected(node):
	if node in selected_nodes:
		selected_nodes.erase(node)

func _on_graph_edit_copy_nodes_request():
	node_buffer = []
	for node in selected_nodes:
		for child in $GraphEdit.get_children():
			if is_instance_valid(node) && is_instance_valid(child):
				if node.name == child.name:
					node_buffer.append(_create_node_diccionary(child, [], [], [], [], [], []))

func _on_graph_edit_paste_nodes_request():
	var relativePositions = Vector2(0,0)
	if node_buffer:
		node_buffer.sort_custom(customSort)
		for node in node_buffer:
			relativePositions += node.nodePosition
		relativePositions = relativePositions / node_buffer.size()
		for node in node_buffer:
			var nodeIndexLast = 91
			for child in $GraphEdit.get_children():
				if child.get("nodeID") > nodeIndexLast:
					nodeIndexLast = child.get("nodeID")
			if node.nodeTypeID != 0 and node.nodeTypeID != 1:
				nodeIndexLast += 1
				node.nodeID = nodeIndexLast
				node.nodePosition = (node.nodePosition - relativePositions) + ((get_local_mouse_position() + $GraphEdit.scroll_offset) / $GraphEdit.zoom)
				fileManagementScript._node_processing(node, $GraphEdit, nodeIndex)

# New Button Pressed
func _on_new_button_pressed():
	$NewFileConfirmationDialog.show()

func _on_new_file_confirmation_dialog_confirmed():
	_clean_up_graph()
	initial_instance()

func _clean_up_graph():
	nodeIndex = 90
	nodeInfo = []
	$GraphEdit.clear_connections()
	connectionInfo = []
	for child in $GraphEdit.get_children():
		if child.get_name() != "ContextMenu" and child.get_name() != "BehaviorMenu":
			$GraphEdit.remove_child(child)
			child.queue_free()
	variableMenu._clean_list()
	eventMenu._clean_list()
	transitionMenu._clean_list()
	propertiesMenu._clean_list()
	eventPayloadsMenu._clean_list()

func _on_save_button_pressed():
	$SaveFileDialog.show()

func _on_save_file_dialog_file_selected(path):
	$Buttons/SaveButton.set_pressed(false)
	parse_node_info()
	var saveInfo = [globalVariable.globalTransitionList, globalVariable.globalEventList, globalVariable.globalPayloadList, globalVariable.globalPropertiesList, globalVariable.globalVariableList, nodeInfo, connectionInfo]
	if nodeInfo != []:
		fileManagementScript._save_nodes(saveInfo, path)

func _on_load_button_pressed():
	$LoadFileDialog.show()

func _on_load_file_dialog_file_selected(path):
	$Buttons/LoadButton.set_pressed(false)
	if not FileAccess.file_exists(path):
			return
	_clean_up_graph()
	nodeIndex = fileManagementScript._load_nodes(path, $GraphEdit, nodeIndex)

# Exporting XML
func _on_export_button_pressed():
		$ExportFileDialog.show()

func _on_export_file_dialog_file_selected(path):
	var nodeExportIndex = parse_node_info()
	var file = FileAccess.open(path, FileAccess.WRITE)
	behaviorParserScript._initialize_behavior(file)
	for node in nodeInfo:
		behaviorParserScript._process_node(file, node, nodeExportIndex, len(globalVariable.globalTransitionList), len(globalVariable.globalPayloadList))
	for transition in globalVariable.globalTransitionList:
		nodeExportIndex += 1
		behaviorParserScript._parse_hkbBlendingTransitionEffect(file, transition, nodeExportIndex)
	for payload in globalVariable.globalPayloadList:
		nodeExportIndex += 1
		behaviorParserScript._parse_hkbStringEventPayload(file, payload, nodeExportIndex)
	nodeExportIndex += 1
	behaviorParserScript._parse_hkbBehaviorGraphData(file, globalVariable.globalVariableList, globalVariable.globalEventList, globalVariable.globalPropertiesList, nodeExportIndex)
	nodeExportIndex += 1
	behaviorParserScript._parse_hkbVariableValueSet(file, globalVariable.globalVariableList, nodeExportIndex)
	nodeExportIndex += 1
	behaviorParserScript._parse_hkbBehaviorGraphStringData(file, globalVariable.globalVariableList, globalVariable.globalEventList, globalVariable.globalPropertiesList, nodeExportIndex)
	behaviorParserScript._finish_behavior(file)

# Parse Behavior Info
func parse_node_info():
	nodeInfo = []
	var nodeIndexLast = 90
	_process_connections()
	for child in $GraphEdit.get_children():
		var nodeConnection0 = []
		var nodeConnection1 = []
		var nodeConnection2 = []
		var nodeConnection3 = []
		var nodeConnection4 = []
		var nodeConnection5 = []
		if child.get_name() != "ContextMenu" and child.get_name() != "BehaviorMenu":
			if child.get("nodeID") > nodeIndexLast:
				nodeIndexLast = child.get("nodeID")
			for connection in connectionInfo:
				if child.get("nodeID") == connection[1]:
					match connection[0]:
						0:
							nodeConnection0.append(connection)
						1:
							nodeConnection1.append(connection)
						2:
							nodeConnection2.append(connection)
						3:
							nodeConnection3.append(connection)
						4:
							nodeConnection4.append(connection)
						5:
							nodeConnection5.append(connection)
			nodeInfo.append(_create_node_diccionary(child, nodeConnection0, nodeConnection1, nodeConnection2, nodeConnection3, nodeConnection4, nodeConnection5))
	nodeInfo.sort_custom(customSort)
	return nodeIndexLast

# Sort the array of nodes by their ID.
func customSort(a, b):
	return a["nodeID"] < b["nodeID"]

func _create_node_diccionary(child, nodeConnection0, nodeConnection1, nodeConnection2, nodeConnection3, nodeConnection4, nodeConnection5):
	var data = {
		# Base Node Values
		"nodeTypeID": child.get("nodeTypeID"),
		"nodePosition": child.get_position_offset(),
		"nodeID": child.get("nodeID"),
		# Node Values
		"nodeName": child.get("nodeName"),
		"stateId": child.get("stateId"),
		"initialStateId": child.get("initialStateId"),
		"startStateId": child.get("startStateId"),
		"enable": child.get("enable"),
		"probability": child.get("probability"),
		"transitionArray": child.get("transitionArray"),
		"eventsArray": child.get("eventsArray"),
		"userData": child.get("userData"),
		"groundNormal": child.get("groundNormal"),
		"duration": child.get("duration"),
		"alignWithGroundDuration": child.get("alignWithGroundDuration"),
		"rootBoneIndex": child.get("rootBoneIndex"),
		"otherBoneIndex": child.get("otherBoneIndex"),
		"anotherBoneIndex": child.get("anotherBoneIndex"),
		"bindingArray": child.get("bindingArray"),
		"indexOfBindingToEnable": child.get("indexOfBindingToEnable"),
		"randomTransitionEventId": child.get("randomTransitionEventId"),
		"transitionToNextHigherStateEventId": child.get("transitionToNextHigherStateEventId"),
		"transitionToNextLowerStateEventId": child.get("transitionToNextLowerStateEventId"),
		"syncVariableIndex": child.get("syncVariableIndex"),
		"wrapAroundStateId": child.get("wrapAroundStateId"),
		"startStateMode": child.get("startStateMode"),
		"eventMode": child.get("eventMode"),
		"blendInDuration": child.get("blendInDuration"),
		"blendOutDuration": child.get("blendOutDuration"),
		"syncToGeneratorStartTime": child.get("syncToGeneratorStartTime"),
		"selfTransitionMode": child.get("selfTransitionMode"),
		"eventId": child.get("eventId"),
		"payload": child.get("payload"),
		"pSequence": child.get("pSequence"),
		"eBlendModeFunction": child.get("eBlendModeFunction"),
		"fPercent": child.get("fPercent"),
		"eUseTimePercentage": child.get("eUseTimePercentage"),
		"fTimePercent": child.get("fTimePercent"),
		"bIsActiveArray": child.get("bIsActiveArray"),
		"selectedGeneratorIndex": child.get("selectedGeneratorIndex"),
		"selectedIndexCanChangeAfterActivate": child.get("selectedIndexCanChangeAfterActivate"),
		"generatorChangedTransitionEffect": child.get("generatorChangedTransitionEffect"),
		"boneIndices": child.get("boneIndices"),
		"boneWeights": child.get("boneWeights"),
		"hierarchyGain": child.get("hierarchyGain"),
		"velocityDamping": child.get("velocityDamping"),
		"accelerationGain": child.get("accelerationGain"),
		"velocityGain": child.get("velocityGain"),
		"positionGain": child.get("positionGain"),
		"positionMaxLinearVelocity": child.get("positionMaxLinearVelocity"),
		"positionMaxAngularVelocity": child.get("positionMaxAngularVelocity"),
		"snapGain": child.get("snapGain"),
		"snapMaxLinearVelocity": child.get("snapMaxLinearVelocity"),
		"snapMaxAngularVelocity": child.get("snapMaxAngularVelocity"),
		"snapMaxLinearDistance": child.get("snapMaxLinearDistance"),
		"snapMaxAngularDistance": child.get("snapMaxAngularDistance"),
		"durationToBlend": child.get("durationToBlend"),
		"animationBlendFraction": child.get("animationBlendFraction"),
		"expressionArray": child.get("expressionArray"),
		"blendParameter": child.get("blendParameter"),
		"blendSpeed": child.get("blendSpeed"),
		"minSpeedToSwitch": child.get("minSpeedToSwitch"),
		"startPlayingEventId": child.get("startPlayingEventId"),
		"startMatchingEventId": child.get("startMatchingEventId"),
		"pelvisIndex": child.get("pelvisIndex"),
		"maxCyclicBlendParameter": child.get("maxCyclicBlendParameter"),
		"indexOfSyncMasterChild": child.get("indexOfSyncMasterChild"),
		"flagsIndex": child.get("flagsIndex"),
		"weight": child.get("weight"),
		"worldFromModelWeight": child.get("worldFromModelWeight"),
		"animationName": child.get("animationName"),
		"cropStartAmountLocalTime": child.get("cropStartAmountLocalTime"),
		"cropEndAmountLocalTime": child.get("cropEndAmountLocalTime"),
		"startTime": child.get("startTime"),
		"playbackSpeed": child.get("playbackSpeed"),
		"enforcedDuration": child.get("enforcedDuration"),
		"userControlledTimeFraction": child.get("userControlledTimeFraction"),
		"mode": child.get("mode"),
		"triggersArray": child.get("triggersArray"),
		"alarmTimeSeconds": child.get("alarmTimeSeconds"),
		"activateEventId": child.get("activateEventId"),
		"deactivateEventId": child.get("deactivateEventId"),
		"activeByDefault": child.get("activeByDefault"),
		"maxForce": child.get("maxForce"),
		"tau": child.get("tau"),
		"damping": child.get("damping"),
		"proportionalRecoveryVelocity": child.get("proportionalRecoveryVelocity"),
		"constantRecoveryVelocity": child.get("constantRecoveryVelocity"),
		"poseMatchingBone0": child.get("poseMatchingBone0"),
		"poseMatchingBone1": child.get("poseMatchingBone1"),
		"poseMatchingBone2": child.get("poseMatchingBone2"),
		"timeStep": child.get("timeStep"),
		"axisOfRotation": child.get("axisOfRotation"),
		"twistAngle": child.get("twistAngle"),
		"startBoneIndex": child.get("startBoneIndex"),
		"endBoneIndex": child.get("endBoneIndex"),
		"setAngleMethod": child.get("setAngleMethod"),
		"rotationAxisCoordinates": child.get("rotationAxisCoordinates"),
		"isAdditive": child.get("isAdditive"),
		"source": child.get("source"),
		"target": child.get("target"),
		"result": child.get("result"),
		"gain": child.get("gain"),
		"inputValue": child.get("inputValue"),
		"lowerBound": child.get("lowerBound"),
		"behaviorName": child.get("behaviorName"),
		"floatVariable": child.get("floatVariable"),
		"floatValue": child.get("floatValue"),
		"intVariable": child.get("intVariable"),
		"intValue": child.get("intValue"),
		"resetAlarm": child.get("resetAlarm"),
		"EventToFreezeBlendValueID": child.get("EventToFreezeBlendValueID"),
		"EventToFreezeBlendValuePayload": child.get("EventToFreezeBlendValuePayload"),
		"EventToCrossBlendID": child.get("EventToCrossBlendID"),
		"EventToCrossBlendPayload": child.get("EventToCrossBlendPayload"),
		"TransitionOutEventID": child.get("TransitionOutEventID"),
		"TransitionOutEventPayload": child.get("TransitionOutEventPayload"),
		"TransitionInEventID": child.get("TransitionInEventID"),
		"TransitionInEventPayload": child.get("TransitionInEventPayload"),
		"fTransitionDuration": child.get("fTransitionDuration"),
		"rangeArray": child.get("rangeArray"),
		"kP": child.get("kP"),
		"kI": child.get("kI"),
		"kD": child.get("kD"),
		"enableScalarDamping": child.get("enableScalarDamping"),
		"enableVectorDamping": child.get("enableVectorDamping"),
		"rawValue": child.get("rawValue"),
		"dampedValue": child.get("dampedValue"),
		"rawVector": child.get("rawVector"),
		"dampedVector": child.get("dampedVector"),
		"vecErrorSum": child.get("vecErrorSum"),
		"vecPreviousError": child.get("vecPreviousError"),
		"errorSum": child.get("errorSum"),
		"previousError": child.get("previousError"),
		"nodeConnection0": nodeConnection0,
		"nodeConnection1": nodeConnection1,
		"nodeConnection2": nodeConnection2,
		"nodeConnection3": nodeConnection3,
		"nodeConnection4": nodeConnection4,
		"nodeConnection5": nodeConnection5,
	}
	return data

func _on_import_button_pressed():
	$ImportFileDialog.show()

func _on_import_file_dialog_file_selected(path):
	_clean_up_graph()
	var unhandledNodes = []
	var unhandledNodeDialog = ""
	unhandledNodes = xmlImportScript._load_XML(path, $GraphEdit)
	$AlphaImportingDialog.dialog_text = "This feature is still incomplete and won't import all graph data and connections yet.\r\nDue to a bug from HKXPack, variables don't export all of their boundaries."
	for node in unhandledNodes:
		if node != null:
			if !unhandledNodeDialog:
				unhandledNodeDialog = "\r\n\r\nThe following nodes weren't loaded: \r\n"
			unhandledNodeDialog += node + "\r\n"
	if unhandledNodeDialog:
		$AlphaImportingDialog.dialog_text += unhandledNodeDialog
		$AlphaImportingDialog.dialog_text += "Send the developer a message about it."
	$GraphEdit.arrange_nodes()
	$AlphaImportingDialog.show()

# Behavior Info Menus
func _on_variables_button_toggled(toggled_on):
	if toggled_on:
		$GraphEdit.hide()
		$Buttons/CreateNodeButton.hide()
		$Buttons/CreditsButton.hide()
		variableMenu.show()
	else:
		variableMenu.hide()
		$GraphEdit.show()
		$Buttons/CreateNodeButton.show()
		$Buttons/CreditsButton.show()

func _on_events_button_toggled(toggled_on):
	if toggled_on:
		$GraphEdit.hide()
		$Buttons/CreateNodeButton.hide()
		$Buttons/CreditsButton.hide()
		eventMenu.show()
	else:
		eventMenu.hide()
		$GraphEdit.show()
		$Buttons/CreateNodeButton.show()
		$Buttons/CreditsButton.show()

func _on_properties_button_toggled(toggled_on):
	if toggled_on:
		$GraphEdit.hide()
		$Buttons/CreateNodeButton.hide()
		$Buttons/CreditsButton.hide()
		propertiesMenu.show()
	else:
		propertiesMenu.hide()
		$GraphEdit.show()
		$Buttons/CreateNodeButton.show()
		$Buttons/CreditsButton.show()

func _on_transitions_button_toggled(toggled_on):
	if toggled_on:
		$GraphEdit.hide()
		$Buttons/CreateNodeButton.hide()
		$Buttons/CreditsButton.hide()
		transitionMenu.show()
	else:
		transitionMenu.hide()
		$GraphEdit.show()
		$Buttons/CreateNodeButton.show()
		$Buttons/CreditsButton.show()

func _on_event_payloads_button_toggled(toggled_on):
	if toggled_on:
		$GraphEdit.hide()
		$Buttons/CreateNodeButton.hide()
		eventPayloadsMenu.show()
	else:
		eventPayloadsMenu.hide()
		$GraphEdit.show()
		$Buttons/CreateNodeButton.show()
		$Buttons/CreditsButton.show()

func _acquire_global_values():
	globalVariable.globalTransitionList		= $GraphMenu/TransitionMenu.transitionList
	globalVariable.globalEventList			= $GraphMenu/EventMenu.eventList
	globalVariable.globalPayloadList		= $GraphMenu/PayloadsMenu.payloadList
	globalVariable.globalPropertiesList		= $GraphMenu/PropertiesMenu.propertiesList
	globalVariable.globalVariableList		= $GraphMenu/VariableMenu.variableList
	
func _load_global_values(loadedTransitionList, loadedEventList, loadedPayloadList, loadedPropertiesList, loadedVariableList):
	globalVariable.globalTransitionList		= loadedTransitionList
	globalVariable.globalEventList			= loadedEventList
	globalVariable.globalPayloadList		= loadedPayloadList
	globalVariable.globalPropertiesList		= loadedPropertiesList
	globalVariable.globalVariableList		= loadedVariableList
	_instantiate_global_values()
	_acquire_global_values()

func _instantiate_global_values():
	$GraphMenu/TransitionMenu._load_global_values()
	$GraphMenu/EventMenu._load_global_values()
	$GraphMenu/PayloadsMenu._load_global_values()
	$GraphMenu/PropertiesMenu._load_global_values()
	$GraphMenu/VariableMenu._load_global_values()

func _on_credits_button_pressed():
	$AcceptDialog.show()




