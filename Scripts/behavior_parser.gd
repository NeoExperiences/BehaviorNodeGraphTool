extends Node

# Open the XML file.
func _initialize_behavior(file):
	file.store_string('<?xml version="1.0" encoding="ASCII" standalone="no"?>\r\n')
	file.store_string('<hkpackfile classversion="11" contentsversion="hk_2014.1.0-r1">\r\n')
	file.store_string('    <hksection name="__data__">\r\n')

# Close the XML file.
func _finish_behavior(file):
	file.store_string('    </hksection>\r\n')
	file.store_string('</hkpackfile>\r\n')

func _process_node(file, node, nodeExportIndex, transitionArrayLength, payloadArrayLength):
	match node.nodeTypeID:
		0:
			print("Type of Node: hkRootLevelContainer")
			_parse_hkRootLevelContainer(file, node)
		1:
			print("Type of Node: hkbBehaviorGraph")
			_parse_hkbBehaviorGraph(file, node, nodeExportIndex, transitionArrayLength, payloadArrayLength)
		2:
			print("Type of Node: hkbBehaviorGraphData")
		3:
			print("Type of Node: hkbVariableValueSet")
		4:
			print("Type of Node: hkbBehaviorGraphStringData")
		5:
			print("Type of Node: hkbStateMachine")
			_parse_hkbStateMachine(file, node, nodeExportIndex, transitionArrayLength)
		6:
			print("Type of Node: hkbStateMachineInfo")
			_parse_hkbStateMachineInfo(file, node)
		7: # hkbStateMachineTransitionInfoArray
			print("Type of Node: hkbStateMachineTransitionInfoArray")
			_parse_hkbStateMachineTransitionInfoArray(file, node, nodeExportIndex)
		8: # hkbStateMachineEventPropertyArray
			print("Type of Node: hkbStateMachineEventPropertyArray")
			_parse_hkbStateMachineEventPropertyArray(file, node, nodeExportIndex, transitionArrayLength)
		9: # hkbModifierGenerator
			print("Type of Node: hkbModifierGenerator")
			_parse_hkbModifierGenerator(file, node)
		10: # hkbModifierList
			print("Type of Node: hkbModifierList")
			_parse_hkbModifierList(file, node)
		11: # hkbGetUpModifier
			print("Type of Node: hkbGetUpModifier")
			_parse_hkbGetUpModifier(file, node)
		12:
			print("Type of Node: hkbKeyframeBonesModifier")
			_parse_hkbKeyframeBonesModifier(file, node)
		13:
			print("Type of Node: hkbBoneIndexArray")
			_parse_hkbBoneIndexArray(file, node)
		14:
			print("Type of Node: hkbBoneWeightArray")
			_parse_hkbBoneWeightArray(file, node)
		15:
			print("Type of Node: hkbRigidBodyRagdollControlsModifier")
			_parse_hkbRigidBodyRagdollControlsModifier(file, node)
		16:
			print("Type of Node: BSIsActiveModifier")
			_parse_BSIsActiveModifier(file, node)
		17:
			print("Type of Node: hkbVariableBindingSet")
			_parse_hkbVariableBindingSet(file, node)
		18:
			print("Type of Node: hkbManualSelectorGenerator")
			_parse_hkbManualSelectorGenerator(file, node, nodeExportIndex)
		19:
			print("Type of Node: BSModifyOnceModifier")
			_parse_BSModifyOnceModifier(file, node)
		20:
			print("Type of Node: hkbEvaluateExpressionModifier")
			_parse_hkbEvaluateExpressionModifier(file, node)
		21:
			print("Type of Node: hkbExpressionDataArray")
			_parse_hkbExpressionDataArray(file, node)
		22:
			print("Type of Node: hkbPoseMatchingGenerator")
			_parse_hkbPoseMatchingGenerator(file, node)
		23:
			print("Type of Node: hkbBlenderGenerator")
			_parse_hkbBlenderGenerator(file, node)
		24:
			print("Type of Node: hkbBlenderGeneratorChild")
			_parse_hkbBlenderGeneratorChild(file, node)
		25:
			print("Type of Node: hkbClipGenerator")
			_parse_hkbClipGenerator(file, node)
		26:
			print("Type of Node: hkbClipTriggerArray")
			_parse_hkbClipTriggerArray(file, node, nodeExportIndex, transitionArrayLength)
		27:
			print("Type of Node: hkbBlendingTransitionEffect")
		28:
			print("Type of Node: hkbEventDrivenModifier")
			_parse_hkbEventDrivenModifier(file, node)
		29:
			print("Type of Node: hkbPoweredRagdollControlsModifier")
			_parse_hkbPoweredRagdollControlsModifier(file, node)
		30:
			print("Type of Node: hkbTimerModifier")
			_parse_hkbTimerModifier(file, node, nodeExportIndex, transitionArrayLength)
		31:
			print("Type of Node: BSLookAtModifier")
		32:
			print("Type of Node: BSGetTimeStepModifier")
			_parse_BSGetTimeStepModifier(file, node)
		33:
			print("Type of Node: hkbTwistModifier")
			_parse_hkbTwistModifier(file, node)
		34:
			print("Type of Node: BSInterpValueModifier")
			_parse_BSInterpValueModifier(file, node)
		35:
			print("Type of Node: hkbEventsFromRangeModifier")
			_parse_hkbEventsFromRangeModifier(file, node)
		36:
			print("Type of Node: hkbEventRangeDataArray")
			_parse_hkbEventRangeDataArray(file, node, nodeExportIndex, transitionArrayLength)
		37:
			print("Type of Node: BSBehaviorGraphSwapGenerator")
			_parse_BSBehaviorGraphSwapGenerator(file, node)
		38:
			print("Type of Node: BSRagdollContactListenerModifier")
		39:
			print("Type of Node: BSCyclicBlendTransitionGenerator")
			_parse_BSCyclicBlendTransitionGenerator(file, node, nodeExportIndex, transitionArrayLength)
		40:
			print("Type of Node: BGSGamebryoSequenceGenerator")
			_parse_BGSGamebryoSequenceGenerator(file, node)
		41:
			print("Type of Node: hkbStringEventPayload")
		42:
			print("Type of Node: hkbBehaviorReferenceGenerator")
			_parse_hkbBehaviorReferenceGenerator(file, node)
		43:
			print("Type of Node: BSAssignVariablesModifier")
			_parse_BSAssignVariablesModifier(file, node)
		44:
			print("Type of Node: DynamicAnimationTaggingGenerator")
			_parse_DynamicAnimationTaggingGenerator(file, node)
		45:
			print("Type of Node: BSTimerModifier")
			_parse_BSTimerModifier(file, node, nodeExportIndex, transitionArrayLength)
		46:
			print("Type of Node: BSiStateTaggingGenerator")
		47:
			print("Type of Node: hkbGeneratorTransitionEffect")
			_parse_hkbGeneratorTransitionEffect(file, node)
		48: # hkbReferencePoseGenerator
			print("Type of Node: hkbReferencePoseGenerator")
			_parse_hkbReferencePoseGenerator(file, node)
		49: # hkbDampingModifier
			print("Type of Node: hkbDampingModifier")

func _parse_hkRootLevelContainer(file, node): # Done
	file.store_string('        <hkobject class="hkRootLevelContainer" name="#' + str(node.nodeID) + '" signature="0x2772c11e">\r\n')
	file.store_string('            <hkparam name="namedVariants" numelements="1">\r\n')
	file.store_string('                <hkobject>\r\n')
	file.store_string('                    <hkparam name="name">hkbBehaviorGraph</hkparam>\r\n')
	file.store_string('                    <hkparam name="className">hkbBehaviorGraph</hkparam>\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('                    <hkparam name="variant">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('                    <hkparam name="variant">null</hkparam>\r\n')
	file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbBehaviorGraph(file, node, nodeExportIndex, transitionArrayLength, payloadArrayLength): # Done
	file.store_string('        <hkobject class="hkbBehaviorGraph" name="#' + str(node.nodeID) + '" signature="0xfdedb83b">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">0</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- partitionInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- syncInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad4 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="variableMode">VARIABLE_MODE_DISCARD_WHEN_INACTIVE</hkparam>\r\n')
	file.store_string('            <!-- uniqueIdPool SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- idToStateMachineTemplateMap SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- mirroredExternalIdMap SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pseudoRandomGenerator SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="rootGenerator">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="rootGenerator">null</hkparam>\r\n')
	file.store_string('            <hkparam name="data">#' + str(1 + nodeExportIndex + transitionArrayLength + payloadArrayLength) + '</hkparam>\r\n')
	file.store_string('            <!-- template SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- rootGeneratorClone SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- activeNodes SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- globalTransitionData SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- eventIdMap SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- attributeIdMap SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- variableIdMap SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- characterPropertyIdMap SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- variableValueSet SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeTemplateToCloneMap SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- stateListenerTemplateToCloneMap SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- recentlyCreatedClones SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodePartitionInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- numIntermediateOutputs SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- intermediateOutputSizes SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- jobs SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- allPartitionMemory SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- internalToRootVariableIdMap SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- internalToCharacterCharacterPropertyIdMap SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- internalToRootAttributeIdMap SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nextUniqueId SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- isActive SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- isLinked SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- updateActiveNodes SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- updateActiveNodesForEnable SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- checkNodeValidity SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- stateOrTransitionChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbStateMachine(file, node, nodeExportIndex, transitionArrayLength): # Done
	file.store_string('        <hkobject class="hkbStateMachine" name="#' + str(node.nodeID) + '" signature="0xa5896bcf">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- partitionInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- syncInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad4 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="eventToSendWhenStateOrTransitionChanges">\r\n')
	file.store_string('                <hkobject class="hkbEvent" name="eventToSendWhenStateOrTransitionChanges" signature="0x3e0fd810">\r\n')
	if node.eventId != -1:
		file.store_string('                    <hkparam name="id">' + str(node.eventId) + '</hkparam>\r\n')
	else:
		file.store_string('                    <hkparam name="id">-1</hkparam>\r\n')
	if node.payload != -1:
		file.store_string('                    <hkparam name="payload">#' + str(nodeExportIndex + node.payload + transitionArrayLength) + '</hkparam>\r\n')
	else:
		file.store_string('                    <hkparam name="payload">null</hkparam>\r\n')
	file.store_string('                    <!-- sender SERIALIZE_IGNORED -->\r\n')
	file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('            <hkparam name="startStateIdSelector">null</hkparam>\r\n')
	file.store_string('            <hkparam name="startStateId">' + str(node.startStateId) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="returnToPreviousStateEventId">-1</hkparam>\r\n')
	file.store_string('            <hkparam name="randomTransitionEventId">' + str(node.randomTransitionEventId) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="transitionToNextHigherStateEventId">' + str(node.transitionToNextHigherStateEventId) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="transitionToNextLowerStateEventId">' + str(node.transitionToNextLowerStateEventId) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="syncVariableIndex">' + str(node.syncVariableIndex) + '</hkparam>\r\n')
	file.store_string('            <!-- currentStateId SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="wrapAroundStateId">' + str(node.wrapAroundStateId) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="maxSimultaneousTransitions">32</hkparam>\r\n')
	file.store_string('            <hkparam name="startStateMode">' + str(node.startStateMode) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="selfTransitionMode">' + str(node.selfTransitionMode) + '</hkparam>\r\n')
	file.store_string('            <!-- isActive SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="states" numelements="' + str(node.nodeConnection1.size()) + '">\r\n')
	for state in node.nodeConnection1:
		file.store_string('            #' + str(state[2]) + '\r\n')
	file.store_string('            </hkparam>\r\n')
	if node.nodeConnection2.size() != 0:
		file.store_string('            <hkparam name="wildcardTransitions">#' + str(node.nodeConnection2[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="wildcardTransitions">null</hkparam>\r\n')
	file.store_string('            <!-- stateIdToIndexMap SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- activeTransitions SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- transitionFlags SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- wildcardTransitionFlags SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- delayedTransitions SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- timeInState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- lastLocalTime SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- previousStateId SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nextStartStateIndexOverride SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- stateOrTransitionChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- echoNextUpdate SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEventlessWildcardTransitions SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- sCurrentStateIndexAndEntered SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbStateMachineInfo(file, node): # Done
	file.store_string('        <hkobject class="hkbStateMachineStateInfo" name="#' + str(node.nodeID) + '" signature="0x39d76713">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="listeners" numelements="0">\r\n')
	file.store_string('            </hkparam>\r\n')
	if node.nodeConnection1.size() != 0:
		file.store_string('            <hkparam name="enterNotifyEvents">#' + str(node.nodeConnection1[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="enterNotifyEvents">null</hkparam>\r\n')
	if node.nodeConnection2.size() != 0:
		file.store_string('            <hkparam name="exitNotifyEvents">#' + str(node.nodeConnection2[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="exitNotifyEvents">null</hkparam>\r\n')
	if node.nodeConnection3.size() != 0:
		file.store_string('            <hkparam name="transitions">#' + str(node.nodeConnection3[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="transitions">null</hkparam>\r\n')
	if node.nodeConnection4.size() != 0:
		file.store_string('            <hkparam name="generator">#' + str(node.nodeConnection4[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="generator">null</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="stateId">' + str(node.stateId) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="probability">' + str(node.probability) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="enable">' + str(node.enable) + '</hkparam>\r\n')
	file.store_string('            <!-- hasEventlessTransitions SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')
	
func _parse_hkbStateMachineTransitionInfoArray(file, node, nodeExportIndex): # TODO: TimeInterval and initiateInterval values.
	file.store_string('        <hkobject class="hkbStateMachineTransitionInfoArray" name="#' + str(node.nodeID) + '" signature="0x704a19af">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="transitions" numelements="' + str(node.transitionArray.size()) + '">\r\n')
	for transition in node.transitionArray:
		var parsedFlags = _flags_parser(transition.flags)
		file.store_string('                <hkobject>\r\n')
		file.store_string('                    <hkparam name="triggerInterval">\r\n')
		file.store_string('                        <hkobject class="hkbStateMachineTimeInterval" name="triggerInterval" signature="0x60a881e5">\r\n')
		file.store_string('                            <hkparam name="enterEventId">-1</hkparam>\r\n')
		file.store_string('                            <hkparam name="exitEventId">-1</hkparam>\r\n')
		file.store_string('                            <hkparam name="enterTime">0.0</hkparam>\r\n')
		file.store_string('                            <hkparam name="exitTime">0.0</hkparam>\r\n')
		file.store_string('                        </hkobject>\r\n')
		file.store_string('                    </hkparam>\r\n')
		file.store_string('                    <hkparam name="initiateInterval">\r\n')
		file.store_string('                        <hkobject class="hkbStateMachineTimeInterval" name="initiateInterval" signature="0x60a881e5">\r\n')
		file.store_string('                            <hkparam name="enterEventId">-1</hkparam>\r\n')
		file.store_string('                            <hkparam name="exitEventId">-1</hkparam>\r\n')
		file.store_string('                            <hkparam name="enterTime">0.0</hkparam>\r\n')
		file.store_string('                            <hkparam name="exitTime">0.0</hkparam>\r\n')
		file.store_string('                        </hkobject>\r\n')
		file.store_string('                    </hkparam>\r\n')
		file.store_string('                    <hkparam name="transition">#' + str(nodeExportIndex + transition.transition + 1) + '</hkparam>\r\n')
		file.store_string('                    <hkparam name="condition">null</hkparam>\r\n')
		file.store_string('                    <hkparam name="eventId">' + str(transition.eventId) + '</hkparam>\r\n')
		file.store_string('                    <hkparam name="toStateId">' + str(transition.toStateId) + '</hkparam>\r\n')
		file.store_string('                    <hkparam name="fromNestedStateId">' + str(transition.fromNestedStateId) + '</hkparam>\r\n')
		file.store_string('                    <hkparam name="toNestedStateId">' + str(transition.toNestedStateId) + '</hkparam>\r\n')
		file.store_string('                    <hkparam name="priority">' + str(transition.priority) + '</hkparam>\r\n')
		file.store_string('                    <hkparam name="flags">' + str(parsedFlags) + '</hkparam>\r\n')
		file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('            <!-- hasEventlessTransitions SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasTimeBoundedTransitions SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _flags_parser(flags):
	var parsedFlags = ""
	if flags[0]:
		if parsedFlags == "":
			parsedFlags += "FLAG_USE_TRIGGER_INTERVAL"
		else:
			parsedFlags += "|FLAG_USE_TRIGGER_INTERVAL"
	if flags[1]:
		if parsedFlags == "":
			parsedFlags += "FLAG_USE_INITIATE_INTERVAL"
		else:
			parsedFlags += "|FLAG_USE_INITIATE_INTERVAL"
	if flags[2]:
		if parsedFlags == "":
			parsedFlags += "FLAG_UNINTERRUPTIBLE_WHILE_PLAYING"
		else:
			parsedFlags += "|FLAG_UNINTERRUPTIBLE_WHILE_PLAYING"
	if flags[3]:
		if parsedFlags == "":
			parsedFlags += "FLAG_UNINTERRUPTIBLE_WHILE_DELAYED"
		else:
			parsedFlags += "|FLAG_UNINTERRUPTIBLE_WHILE_DELAYED"
	if flags[4]:
		if parsedFlags == "":
			parsedFlags += "FLAG_DELAY_STATE_CHANGE"
		else:
			parsedFlags += "|FLAG_DELAY_STATE_CHANGE"
	if flags[5]:
		if parsedFlags == "":
			parsedFlags += "FLAG_DISABLED"
		else:
			parsedFlags += "|FLAG_DISABLED"
	if flags[6]:
		if parsedFlags == "":
			parsedFlags += "FLAG_DISALLOW_RETURN_TO_PREVIOUS_STATE"
		else:
			parsedFlags += "|FLAG_DISALLOW_RETURN_TO_PREVIOUS_STATE"
	if flags[7]:
		if parsedFlags == "":
			parsedFlags += "FLAG_DISALLOW_RANDOM_TRANSITION"
		else:
			parsedFlags += "|FLAG_DISALLOW_RANDOM_TRANSITION"
	if flags[8]:
		if parsedFlags == "":
			parsedFlags += "FLAG_DISABLE_CONDITION"
		else:
			parsedFlags += "|FLAG_DISABLE_CONDITION"
	if flags[9]:
		if parsedFlags == "":
			parsedFlags += "FLAG_ALLOW_SELF_TRANSITION_BY_TRANSITION_FROM_ANY_STATE"
		else:
			parsedFlags += "|FLAG_ALLOW_SELF_TRANSITION_BY_TRANSITION_FROM_ANY_STATE"
	if flags[10]:
		if parsedFlags == "":
			parsedFlags += "FLAG_IS_GLOBAL_WILDCARD"
		else:
			parsedFlags += "|FLAG_IS_GLOBAL_WILDCARD"
	if flags[11]:
		if parsedFlags == "":
			parsedFlags += "FLAG_IS_LOCAL_WILDCARD"
		else:
			parsedFlags += "|FLAG_IS_LOCAL_WILDCARD"
	if flags[12]:
		if parsedFlags == "":
			parsedFlags += "FLAG_FROM_NESTED_STATE_ID_IS_VALID"
		else:
			parsedFlags += "|FLAG_FROM_NESTED_STATE_ID_IS_VALID"
	if flags[13]:
		if parsedFlags == "":
			parsedFlags += "FLAG_TO_NESTED_STATE_ID_IS_VALID"
		else:
			parsedFlags += "|FLAG_TO_NESTED_STATE_ID_IS_VALID"
	if flags[14]:
		if parsedFlags == "":
			parsedFlags += "FLAG_ABUT_AT_END_OF_FROM_GENERATOR"
		else:
			parsedFlags += "|FLAG_ABUT_AT_END_OF_FROM_GENERATOR"
	if parsedFlags == "":
		parsedFlags = "0"
	return parsedFlags

func _parse_hkbStateMachineEventPropertyArray(file, node, nodeExportIndex, transitionArrayLength): # Done
	file.store_string('        <hkobject class="hkbStateMachineEventPropertyArray" name="#' + str(node.nodeID) + '" signature="0x71957c2d">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="events" numelements="'+ str(node.eventsArray.size()) +'">\r\n')
	for event in node.eventsArray:
		file.store_string('                <hkobject>\r\n')
		file.store_string('                    <hkparam name="id">' + str(event.eventID) + '</hkparam>\r\n')
		if event.payloadID != null && event.payloadID != -1:
			file.store_string('                    <hkparam name="payload">#' + str(nodeExportIndex + event.payloadID + transitionArrayLength) + '</hkparam>\r\n')
		else:
			file.store_string('                    <hkparam name="payload">null</hkparam>\r\n')
		file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbModifierGenerator(file, node): # Done
	file.store_string('        <hkobject class="hkbModifierGenerator" name="#' + str(node.nodeID) + '" signature="0xc499fc9e">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- partitionInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- syncInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad4 SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection1.size() != 0:
		file.store_string('            <hkparam name="modifier">#' + str(node.nodeConnection1[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="modifier">null</hkparam>\r\n')
	if node.nodeConnection2.size() != 0:
		file.store_string('            <hkparam name="generator">#' + str(node.nodeConnection2[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="generator">null</hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbModifierList(file, node): # Done
	file.store_string('        <hkobject class="hkbModifierList" name="#' + str(node.nodeID) + '" signature="0xded564c">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="enable">' + str(node.enable) + '</hkparam>\r\n')
	file.store_string('            <!-- padModifier1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="modifiers" numelements="'+ str(node.nodeConnection1.size()) +'">\r\n')
	for modifier in node.nodeConnection1:
		file.store_string('            #' + str(modifier[2]) + '\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbGetUpModifier(file, node): # Done
	file.store_string('        <hkobject class="hkbGetUpModifier" name="#' + str(node.nodeID) + '" signature="0x84519a60">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="enable">' + str(node.enable) + '</hkparam>\r\n')
	file.store_string('            <!-- padModifier1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="groundNormal">' + str(node.groundNormal) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="duration">' + str(node.duration) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="alignWithGroundDuration">' + str(node.alignWithGroundDuration) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="rootBoneIndex">' + str(node.rootBoneIndex) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="otherBoneIndex">' + str(node.otherBoneIndex) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="anotherBoneIndex">' + str(node.anotherBoneIndex) + '</hkparam>\r\n')
	file.store_string('            <!-- timeSinceBegin SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- timeStep SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- initNextModify SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbKeyframeBonesModifier(file, node): # Done
	file.store_string('        <hkobject class="hkbKeyframeBonesModifier" name="#' + str(node.nodeID) + '" signature="0x4e45d0f7">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="enable">true</hkparam>\r\n')
	file.store_string('            <!-- padModifier1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="keyframeInfo" numelements="0"/>\r\n')
	if node.nodeConnection1.size() != 0:
		file.store_string('            <hkparam name="keyframedBonesList">#' + str(node.nodeConnection1[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="keyframedBonesList">null</hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbBoneIndexArray(file, node): # Done
	file.store_string('        <hkobject class="hkbBoneIndexArray" name="#' + str(node.nodeID) + '" signature="0x3d26f425">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	if len(node.boneIndices) == 0:
		file.store_string('            <hkparam name="boneIndices" numelements="0"/>\r\n')
	else:
		file.store_string('            <hkparam name="boneIndices" numelements="' + str(len(node.boneIndices)) + '">\r\n')
		var boneString = ""
		for boneIndex in node.boneIndices:
			boneString += str(boneIndex) + " "
		file.store_string('            ' + boneString + '\r\n')
		file.store_string('            </hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')
	
func _parse_hkbBoneWeightArray(file, node): # Done
	file.store_string('        <hkobject class="hkbBoneWeightArray" name="#' + str(node.nodeID) + '" signature="0x2c9b5751">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	if len(node.boneWeights) == 0:
		file.store_string('            <hkparam name="boneWeights" numelements="0"/>\r\n')
	else:
		file.store_string('            <hkparam name="boneWeights" numelements="' + str(len(node.boneWeights)) + '">\r\n')
		var boneString = ""
		for boneWeight in node.boneWeights:
			boneString += str(boneWeight) + " "
		file.store_string('            ' + boneString + '\r\n')
		file.store_string('            </hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbRigidBodyRagdollControlsModifier(file, node): # Done
	file.store_string('        <hkobject class="hkbRigidBodyRagdollControlsModifier" name="#' + str(node.nodeID) + '" signature="0xb7c3fe7d">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="enable">' + str(node.enable) + '</hkparam>\r\n')
	file.store_string('            <!-- padModifier1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="controlData">\r\n')
	file.store_string('                <hkobject class="hkbRigidBodyRagdollControlData" name="controlData" signature="0x34a56bef">\r\n')
	file.store_string('                    <hkparam name="keyFrameControlData">\r\n')
	file.store_string('                        <hkobject class="hkbKeyFrameControlData" name="keyFrameControlData" signature="0xa3d0ac71">\r\n')
	file.store_string('                            <hkparam name="hierarchyGain">' + str(node.hierarchyGain) + '</hkparam>\r\n')
	file.store_string('                            <hkparam name="velocityDamping">' + str(node.velocityDamping) + '</hkparam>\r\n')
	file.store_string('                            <hkparam name="accelerationGain">' + str(node.accelerationGain) + '</hkparam>\r\n')
	file.store_string('                            <hkparam name="velocityGain">' + str(node.velocityGain) + '</hkparam>\r\n')
	file.store_string('                            <hkparam name="positionGain">' + str(node.positionGain) + '</hkparam>\r\n')
	file.store_string('                            <hkparam name="positionMaxLinearVelocity">' + str(node.positionMaxLinearVelocity) + '</hkparam>\r\n')
	file.store_string('                            <hkparam name="positionMaxAngularVelocity">' + str(node.positionMaxAngularVelocity) + '</hkparam>\r\n')
	file.store_string('                            <hkparam name="snapGain">' + str(node.snapGain) + '</hkparam>\r\n')
	file.store_string('                            <hkparam name="snapMaxLinearVelocity">' + str(node.snapMaxLinearVelocity) + '</hkparam>\r\n')
	file.store_string('                            <hkparam name="snapMaxAngularVelocity">' + str(node.snapMaxAngularVelocity) + '</hkparam>\r\n')
	file.store_string('                            <hkparam name="snapMaxLinearDistance">' + str(node.snapMaxLinearDistance) + '</hkparam>\r\n')
	file.store_string('                            <hkparam name="snapMaxAngularDistance">' + str(node.snapMaxAngularDistance) + '</hkparam>\r\n')
	file.store_string('                        </hkobject>\r\n')
	file.store_string('                    </hkparam>\r\n')
	file.store_string('                    <hkparam name="durationToBlend">' + str(node.durationToBlend) + '</hkparam>\r\n')
	file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	if node.nodeConnection1.size() != 0:
		file.store_string('            <hkparam name="bones">#' + str(node.nodeConnection1[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="bones">null</hkparam>\r\n')
	file.store_string('            <hkparam name="animationBlendFraction">' + str(node.animationBlendFraction) + '</hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_BSIsActiveModifier(file, node): # Done
	file.store_string('        <hkobject class="BSIsActiveModifier" name="#' + str(node.nodeID) + '" signature="0x5bf1f5cf">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="enable">' + str(node.enable) + '</hkparam>\r\n')
	file.store_string('            <!-- padModifier1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="bIsActive0">' + str(node.bIsActiveArray[0]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="bInvertActive0">' + str(node.bIsActiveArray[5]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="bIsActive1">' + str(node.bIsActiveArray[1]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="bInvertActive1">' + str(node.bIsActiveArray[6]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="bIsActive2">' + str(node.bIsActiveArray[2]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="bInvertActive2">' + str(node.bIsActiveArray[7]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="bIsActive3">' + str(node.bIsActiveArray[3]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="bInvertActive3">' + str(node.bIsActiveArray[8]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="bIsActive4">' + str(node.bIsActiveArray[4]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="bInvertActive4">' + str(node.bIsActiveArray[9]) + '</hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbVariableBindingSet(file, node): # Done
	file.store_string('        <hkobject class="hkbVariableBindingSet" name="#' + str(node.nodeID) + '" signature="0xe942f339">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="bindings" numelements="' + str(node.bindingArray.size()) + '">\r\n')
	for binding in node.bindingArray:
		file.store_string('                <hkobject>\r\n')
		file.store_string('                    <hkparam name="memberPath">' + str(binding.memberPath) + '</hkparam>\r\n')
		file.store_string('                    <!-- memberClass SERIALIZE_IGNORED -->\r\n')
		file.store_string('                    <!-- offsetInObjectPlusOne SERIALIZE_IGNORED -->\r\n')
		file.store_string('                    <!-- offsetInArrayPlusOne SERIALIZE_IGNORED -->\r\n')
		file.store_string('                    <!-- rootVariableIndex SERIALIZE_IGNORED -->\r\n')
		file.store_string('                    <hkparam name="variableIndex">' + str(binding.variableIndex) + '</hkparam>\r\n')
		file.store_string('                    <hkparam name="bitIndex">255</hkparam>\r\n')
		file.store_string('                    <hkparam name="bindingType">' + str(binding.bindingType) + '</hkparam>\r\n')
		file.store_string('                    <!-- memberType SERIALIZE_IGNORED -->\r\n')
		file.store_string('                    <!-- variableType SERIALIZE_IGNORED -->\r\n')
		file.store_string('                    <!-- flags SERIALIZE_IGNORED -->\r\n')
		file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('            <hkparam name="indexOfBindingToEnable">' + str(node.indexOfBindingToEnable) + '</hkparam>\r\n')
	file.store_string('            <!-- hasOutputBinding SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- initializedOffsets SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbManualSelectorGenerator(file, node, nodeExportIndex): # Done
	file.store_string('        <hkobject class="hkbManualSelectorGenerator" name="#' + str(node.nodeID) + '" signature="0xeed8d5cd">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- partitionInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- syncInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad4 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="generators" numelements="'+ str(node.nodeConnection1.size()) +'">\r\n')
	for generator in node.nodeConnection1:
		file.store_string('            #' + str(generator[2]) + '\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('            <hkparam name="selectedGeneratorIndex">' + str(node.selectedGeneratorIndex) + '</hkparam>\r\n')
	if node.nodeConnection2:
		file.store_string('            <hkparam name="indexSelector">#' + str(node.nodeConnection2[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="indexSelector">null</hkparam>\r\n')
	file.store_string('            <hkparam name="selectedIndexCanChangeAfterActivate">' + str(node.selectedIndexCanChangeAfterActivate) + '</hkparam>\r\n')
	if node.generatorChangedTransitionEffect != 0:
		file.store_string('            <hkparam name="generatorChangedTransitionEffect">#' + str(node.generatorChangedTransitionEffect + nodeExportIndex) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="generatorChangedTransitionEffect">null</hkparam>\r\n')
	file.store_string('            <!-- currentGeneratorIndex SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- generatorIndexAtActivate SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- activeTransitions SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_BSModifyOnceModifier(file, node): # Done
	file.store_string('        <hkobject class="BSModifyOnceModifier" name="#' + str(node.nodeID) + '" signature="0x14f075d2">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="enable">' + str(node.enable) + '</hkparam>\r\n')
	file.store_string('            <!-- padModifier1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier3 SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection1.size() != 0:
		file.store_string('            <hkparam name="pOnActivateModifier">#' + str(node.nodeConnection1[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="pOnActivateModifier">null</hkparam>\r\n')
	if node.nodeConnection2.size() != 0:
		file.store_string('            <hkparam name="pOnDeactivateModifier">#' + str(node.nodeConnection2[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="pOnDeactivateModifier">null</hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbEvaluateExpressionModifier(file, node): # Done
	file.store_string('        <hkobject class="hkbEvaluateExpressionModifier" name="#' + str(node.nodeID) + '" signature="0x4a3ac449">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="enable">' + str(node.enable) + '</hkparam>\r\n')
	file.store_string('            <!-- padModifier1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier3 SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection1.size() != 0:
		file.store_string('            <hkparam name="expressions">#' + str(node.nodeConnection1[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="expressions">null</hkparam>\r\n')
	file.store_string('            <!-- compiledExpressionSet SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- internalExpressionsData SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbExpressionDataArray(file, node): # Done
	file.store_string('        <hkobject class="hkbExpressionDataArray" name="#' + str(node.nodeID) + '" signature="0x1ebfc6d7">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="expressionsData" numelements="' + str(node.expressionArray.size()) + '">\r\n')
	for expression in node.expressionArray:
		file.store_string('                <hkobject>\r\n')
		file.store_string('                    <hkparam name="expression">' + str(expression.expression) + '</hkparam>\r\n')
		file.store_string('                    <hkparam name="assignmentVariableIndex">' + str(expression.assignmentVariableIndex) + '</hkparam>\r\n')
		file.store_string('                    <hkparam name="assignmentEventIndex">' + str(expression.assignmentEventIndex) + '</hkparam>\r\n')
		file.store_string('                    <hkparam name="eventMode">EVENT_MODE_SEND_ONCE</hkparam>\r\n')
		file.store_string('                    <!-- raisedEvent SERIALIZE_IGNORED -->\r\n')
		file.store_string('                    <!-- wasTrueInPreviousFrame SERIALIZE_IGNORED -->\r\n')
		file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbPoseMatchingGenerator(file, node): # Done
	file.store_string('        <hkobject class="hkbPoseMatchingGenerator" name="#' + str(node.nodeID) + '" signature="0xb2aa2982">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- partitionInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- syncInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad4 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="referencePoseWeightThreshold">0.0</hkparam>\r\n')
	file.store_string('            <hkparam name="blendParameter">' + str(node.blendParameter) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="minCyclicBlendParameter">0.0</hkparam>\r\n')
	file.store_string('            <hkparam name="maxCyclicBlendParameter">1.0</hkparam>\r\n')
	file.store_string('            <hkparam name="indexOfSyncMasterChild">65535</hkparam>\r\n')
	file.store_string('            <hkparam name="flags">0</hkparam>\r\n')
	file.store_string('            <hkparam name="subtractLastChild">false</hkparam>\r\n')
	file.store_string('            <hkparam name="children" numelements="'+ str(node.nodeConnection1.size()) +'">\r\n')
	for child in node.nodeConnection1:
		file.store_string('            #' + str(child[2]) + '\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('            <!-- childrenInternalStates SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- sortedChildren SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- endIntervalWeight SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- numActiveChildren SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- beginIntervalIndex SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- endIntervalIndex SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- initSync SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- doSubtractiveBlend SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="worldFromModelRotation">(0.0 0.0 0.0 1.0)</hkparam>\r\n')
	file.store_string('            <hkparam name="blendSpeed">' + str(node.blendSpeed) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="minSpeedToSwitch">' + str(node.minSpeedToSwitch) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="minSwitchTimeNoError">0.20000000298023224</hkparam>\r\n')
	file.store_string('            <hkparam name="minSwitchTimeFullError">0.0</hkparam>\r\n')
	file.store_string('            <hkparam name="startPlayingEventId">' + str(node.startPlayingEventId) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="startMatchingEventId">' + str(node.startMatchingEventId) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="rootBoneIndex">' + str(node.rootBoneIndex) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="otherBoneIndex">' + str(node.otherBoneIndex) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="anotherBoneIndex">' + str(node.anotherBoneIndex) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="pelvisIndex">' + str(node.pelvisIndex) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="mode">MODE_MATCH</hkparam>\r\n')
	file.store_string('            <!-- currentMatch SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- bestMatch SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- timeSinceBetterMatch SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- error SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- resetCurrentMatchLocalTime SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- poseMatchingUtility SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbBlenderGenerator(file, node): # Done
	file.store_string('        <hkobject class="hkbBlenderGenerator" name="#' + str(node.nodeID) + '" signature="0xce45c088">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- partitionInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- syncInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad4 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="referencePoseWeightThreshold">0.0</hkparam>\r\n')
	file.store_string('            <hkparam name="blendParameter">' + str(node.blendParameter) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="minCyclicBlendParameter">0.0</hkparam>\r\n')
	file.store_string('            <hkparam name="maxCyclicBlendParameter">' + str(node.maxCyclicBlendParameter) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="indexOfSyncMasterChild">' + str(node.indexOfSyncMasterChild) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="flags">' + str(node.flagsIndex) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="subtractLastChild">false</hkparam>\r\n')
	file.store_string('            <hkparam name="children" numelements="'+ str(node.nodeConnection1.size()) +'">\r\n')
	for child in node.nodeConnection1:
		file.store_string('            #' + str(child[2]) + '\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('            <!-- childrenInternalStates SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- sortedChildren SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- endIntervalWeight SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- numActiveChildren SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- beginIntervalIndex SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- endIntervalIndex SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- initSync SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- doSubtractiveBlend SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbBlenderGeneratorChild(file, node): # Done
	file.store_string('        <hkobject class="hkbBlenderGeneratorChild" name="#' + str(node.nodeID) + '" signature="0xb35bbfd3">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection1.size() != 0:
		file.store_string('            <hkparam name="generator">#' + str(node.nodeConnection1[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="generator">null</hkparam>\r\n')
	if node.nodeConnection2.size() != 0:
		file.store_string('            <hkparam name="boneWeights">#' + str(node.nodeConnection2[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="boneWeights">null</hkparam>\r\n')
	file.store_string('            <hkparam name="weight">' + str(node.weight) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="worldFromModelWeight">' + str(node.worldFromModelWeight) + '</hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbClipGenerator(file, node): # Done
	file.store_string('        <hkobject class="hkbClipGenerator" name="#' + str(node.nodeID) + '" signature="0xd4cc9f6">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- partitionInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- syncInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad4 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="animationBundleName"/>\r\n')
	file.store_string('            <hkparam name="animationName">' + str(node.animationName) + '</hkparam>\r\n')
	if node.nodeConnection1.size() != 0:
		file.store_string('            <hkparam name="triggers">#' + str(node.nodeConnection1[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="triggers">null</hkparam>\r\n')
	file.store_string('            <hkparam name="userPartitionMask">0</hkparam>\r\n')
	file.store_string('            <hkparam name="cropStartAmountLocalTime">' + str(node.cropStartAmountLocalTime) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="cropEndAmountLocalTime">' + str(node.cropEndAmountLocalTime) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="startTime">' + str(node.startTime) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="playbackSpeed">' + str(node.playbackSpeed) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="enforcedDuration">' + str(node.enforcedDuration) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="userControlledTimeFraction">' + str(node.userControlledTimeFraction) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="animationBindingIndex">65535</hkparam>\r\n')
	if node.mode == 1:
		file.store_string('            <hkparam name="mode">MODE_LOOPING</hkparam>\r\n')
	elif node.mode == 2:
		file.store_string('            <hkparam name="mode">MODE_USER_CONTROLLED</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="mode">MODE_SINGLE_PLAY</hkparam>\r\n')
	file.store_string('            <hkparam name="flags">' + str(node.flagsIndex) + '</hkparam>\r\n')
	file.store_string('            <!-- animDatas SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- animationControl SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- originalTriggers SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- mapperData SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- binding SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- numAnimationTracks SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- extractedMotion SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- echos SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- localTime SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- time SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- previousUserControlledTimeFraction SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- bufferSize SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- atEnd SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- ignoreStartTime SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pingPongBackward SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbClipTriggerArray(file, node, nodeExportIndex, transitionArrayLength): # Done
	file.store_string('        <hkobject class="hkbClipTriggerArray" name="#' + str(node.nodeID) + '" signature="0xf757cd66">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="triggers" numelements="'+ str(node.triggersArray.size()) +'">\r\n')
	for trigger in node.triggersArray:
		file.store_string('                <hkobject>\r\n')
		file.store_string('                    <hkparam name="localTime">' + str(trigger.localTime) + '</hkparam>\r\n')
		file.store_string('                    <hkparam name="event">\r\n')
		file.store_string('                        <hkobject class="hkbEventProperty" name="event" signature="0xdb38a15">\r\n')
		file.store_string('                            <hkparam name="id">' + str(trigger.eventID) + '</hkparam>\r\n')
		if trigger.payloadID != null && trigger.payloadID != -1:
			file.store_string('                            <hkparam name="payload">#' + str(nodeExportIndex + trigger.payloadID + transitionArrayLength) + '</hkparam>\r\n')
		else:
			file.store_string('                            <hkparam name="payload">null</hkparam>\r\n')
		file.store_string('                        </hkobject>\r\n')
		file.store_string('                    </hkparam>\r\n')
		file.store_string('                    <hkparam name="relativeToEndOfClip">' + str(trigger.relativeToEndOfClip) + '</hkparam>\r\n')
		file.store_string('                    <hkparam name="acyclic">' + str(trigger.acyclic) + '</hkparam>\r\n')
		file.store_string('                    <hkparam name="isAnnotation">' + str(trigger.isAnnotation) + '</hkparam>\r\n')
		file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbBlendingTransitionEffect(file, transition, nodeExportIndex): # Done
	file.store_string('        <hkobject class="hkbBlendingTransitionEffect" name="#' + str(nodeExportIndex) + '" signature="0x14e54c5c">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	
	if int(transition.transitionVariableBindingSet) != null && int(transition.transitionVariableBindingSet) != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(transition.transitionVariableBindingSet) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">0</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(transition.transitionName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- partitionInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- syncInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad4 SERIALIZE_IGNORED -->\r\n')
	match transition.transitionSelfTransitionMode:
		0:
			file.store_string('            <hkparam name="selfTransitionMode">SELF_TRANSITION_MODE_CONTINUE_IF_CYCLIC_BLEND_IF_ACYCLIC</hkparam>\r\n')
		1:
			file.store_string('            <hkparam name="selfTransitionMode">SELF_TRANSITION_MODE_CONTINUE</hkparam>\r\n')
		2:
			file.store_string('            <hkparam name="selfTransitionMode">SELF_TRANSITION_MODE_RESET</hkparam>\r\n')
		3:
			file.store_string('            <hkparam name="selfTransitionMode">SELF_TRANSITION_MODE_BLEND</hkparam>\r\n')
	match transition.transitionEventMode:
		0:
			file.store_string('            <hkparam name="eventMode">EVENT_MODE_DEFAULT</hkparam>\r\n')
		1:
			file.store_string('            <hkparam name="eventMode">EVENT_MODE_PROCESS_ALL</hkparam>\r\n')
		2:
			file.store_string('            <hkparam name="eventMode">EVENT_MODE_IGNORE_FROM_GENERATOR</hkparam>\r\n')
		3:
			file.store_string('            <hkparam name="eventMode">EVENT_MODE_IGNORE_TO_GENERATOR</hkparam>\r\n')
	file.store_string('            <!-- defaultEventMode SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- patchedBindingInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- fromGenerator SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- toGenerator SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="duration">' + str(transition.transitionDuration) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="toGeneratorStartTimeFraction">' + str(transition.transitionToGeneratorStartTimeFraction) + '</hkparam>\r\n')
	match transition.transitionFlags:
		0:
			file.store_string('            <hkparam name="flags">FLAG_NONE</hkparam>\r\n')
		1:
			file.store_string('            <hkparam name="flags">FLAG_IGNORE_FROM_WORLD_FROM_MODEL</hkparam>\r\n')
		2:
			file.store_string('            <hkparam name="flags">FLAG_SYNC</hkparam>\r\n')
		3:
			file.store_string('            <hkparam name="flags">FLAG_IGNORE_TO_WORLD_FROM_MODEL</hkparam>\r\n')
		4:
			file.store_string('            <hkparam name="flags">FLAG_IGNORE_TO_WORLD_FROM_MODEL_ROTATION</hkparam>\r\n')
	match transition.transitionEndMode:
		0:
			file.store_string('            <hkparam name="endMode">END_MODE_NONE</hkparam>\r\n')
		1:
			file.store_string('            <hkparam name="endMode">END_MODE_TRANSITION_UNTIL_END_OF_FROM_GENERATOR</hkparam>\r\n')
	file.store_string('            <hkparam name="blendCurve">' + str(transition.transitionBlendCurve) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="alignmentBone">65535</hkparam>\r\n')
	file.store_string('            <!-- fromPos SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- fromRot SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- toPos SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- toRot SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- lastPos SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- lastRot SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- characterPoseAtBeginningOfTransition SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- timeRemaining SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- timeInTransition SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- toGeneratorSelfTranstitionMode SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- initializeCharacterPose SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- alignThisFrame SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- alignmentFinished SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbEventDrivenModifier(file, node): # Done
	file.store_string('        <hkobject class="hkbEventDrivenModifier" name="#' + str(node.nodeID) + '" signature="0x35ef356b">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="enable">' + str(node.enable) + '</hkparam>\r\n')
	file.store_string('            <!-- padModifier1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier3 SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection1.size() != 0:
		file.store_string('            <hkparam name="modifier">#' + str(node.nodeConnection1[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="modifier">null</hkparam>\r\n')
	file.store_string('            <hkparam name="activateEventId">' + str(node.activateEventId) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="deactivateEventId">' + str(node.deactivateEventId) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="activeByDefault">' + str(node.activeByDefault) + '</hkparam>\r\n')
	file.store_string('            <!-- isActive SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbPoweredRagdollControlsModifier(file, node): # Done
	file.store_string('        <hkobject class="hkbPoweredRagdollControlsModifier" name="#' + str(node.nodeID) + '" signature="0x522211cb">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="enable">' + str(node.enable) + '</hkparam>\r\n')
	file.store_string('            <!-- padModifier1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="controlData">\r\n')
	file.store_string('                <hkobject class="hkbPoweredRagdollControlData" name="controlData" signature="0xf5ba21b">\r\n')
	file.store_string('                    <hkparam name="maxForce">' + str(node.maxForce) + '</hkparam>\r\n')
	file.store_string('                    <hkparam name="tau">' + str(node.tau) + '</hkparam>\r\n')
	file.store_string('                    <hkparam name="damping">' + str(node.damping) + '</hkparam>\r\n')
	file.store_string('                    <hkparam name="proportionalRecoveryVelocity">' + str(node.proportionalRecoveryVelocity) + '</hkparam>\r\n')
	file.store_string('                    <hkparam name="constantRecoveryVelocity">' + str(node.constantRecoveryVelocity) + '</hkparam>\r\n')
	file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	if node.nodeConnection1.size() != 0:
		file.store_string('            <hkparam name="bones">#' + str(node.nodeConnection1[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="bones">null</hkparam>\r\n')
	file.store_string('            <hkparam name="worldFromModelModeData">\r\n')
	file.store_string('                <hkobject class="hkbWorldFromModelModeData" name="worldFromModelModeData" signature="0xa3af8783">\r\n')
	file.store_string('                    <hkparam name="poseMatchingBone0">' + str(node.poseMatchingBone0) + '</hkparam>\r\n')
	file.store_string('                    <hkparam name="poseMatchingBone1">' + str(node.poseMatchingBone1) + '</hkparam>\r\n')
	file.store_string('                    <hkparam name="poseMatchingBone2">' + str(node.poseMatchingBone2) + '</hkparam>\r\n')
	if node.mode == 2:
		file.store_string('                    <hkparam name="mode">WORLD_FROM_MODEL_MODE_RAGDOLL</hkparam>\r\n')
	elif node.mode == 1:
		file.store_string('                    <hkparam name="mode">WORLD_FROM_MODEL_MODE_NONE</hkparam>\r\n')
	else:
		file.store_string('                    <hkparam name="mode">WORLD_FROM_MODEL_MODE_COMPUTE</hkparam>\r\n')
	file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	if node.nodeConnection2.size() != 0:
		file.store_string('            <hkparam name="boneWeights">#' + str(node.nodeConnection2[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="boneWeights">null</hkparam>\r\n')
	file.store_string('            <hkparam name="animationBlendFraction">' + str(node.animationBlendFraction) + '</hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbTimerModifier(file, node, nodeExportIndex, transitionArrayLength): # Done
	file.store_string('        <hkobject class="hkbTimerModifier" name="#' + str(node.nodeID) + '" signature="0x7880c5e2">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="enable">' + str(node.enable) + '</hkparam>\r\n')
	file.store_string('            <!-- padModifier1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="alarmTimeSeconds">' + str(node.alarmTimeSeconds) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="alarmEvent">\r\n')
	file.store_string('                <hkobject class="hkbEventProperty" name="alarmEvent" signature="0xdb38a15">\r\n')
	if node.eventId != -1:
		file.store_string('                    <hkparam name="id">' + str(node.eventId) + '</hkparam>\r\n')
	else:
		file.store_string('                    <hkparam name="id">-1</hkparam>\r\n')
	if node.eventId != -1:
		file.store_string('                    <hkparam name="payload">#' + str(nodeExportIndex + node.payload + transitionArrayLength) + '</hkparam>\r\n')
	else:
		file.store_string('                    <hkparam name="payload">null</hkparam>\r\n')
	file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('            <!-- secondsElapsed SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_BSLookAtModifier(file, node):
	print()

func _parse_BSGetTimeStepModifier(file, node): # Done
	file.store_string('        <hkobject class="BSGetTimeStepModifier" name="#' + str(node.nodeID) + '" signature="0x56341150">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="enable">' + str(node.enable) + '</hkparam>\r\n')
	file.store_string('            <!-- padModifier1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="timeStep">' + str(node.timeStep) + '</hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbTwistModifier(file, node): # Done
	file.store_string('        <hkobject class="hkbTwistModifier" name="#' + str(node.nodeID) + '" signature="0x98d623bc">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="enable">' + str(node.enable) + '</hkparam>\r\n')
	file.store_string('            <!-- padModifier1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="axisOfRotation">' + str(node.axisOfRotation) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="twistAngle">' + str(node.twistAngle) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="startBoneIndex">' + str(node.startBoneIndex) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="endBoneIndex">' + str(node.endBoneIndex) + '</hkparam>\r\n')
	if node.setAngleMethod == 1:
			file.store_string('            <hkparam name="setAngleMethod">RAMPED</hkparam>\r\n')
	else:
			file.store_string('            <hkparam name="setAngleMethod">LINEAR</hkparam>\r\n')
	if node.rotationAxisCoordinates == 1:
		file.store_string('            <hkparam name="rotationAxisCoordinates">ROTATION_AXIS_IN_MODEL_COORDINATES</hkparam>\r\n')
	elif node.rotationAxisCoordinates == 2:
		file.store_string('            <hkparam name="rotationAxisCoordinates">ROTATION_AXIS_IN_PARENT_COORDINATES</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="rotationAxisCoordinates">ROTATION_AXIS_IN_LOCAL_COORDINATES</hkparam>\r\n')
	file.store_string('            <hkparam name="isAdditive">' + str(node.isAdditive) + '</hkparam>\r\n')
	file.store_string('            <!-- boneChainIndices SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- parentBoneIndices SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_BSInterpValueModifier(file, node): # Done
	file.store_string('        <hkobject class="BSInterpValueModifier" name="#' + str(node.nodeID) + '" signature="0x4c10e936">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="enable">' + str(node.enable) + '</hkparam>\r\n')
	file.store_string('            <!-- padModifier1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="source">' + str(node.source) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="target">' + str(node.target) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="result">' + str(node.result) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="gain">' + str(node.gain) + '</hkparam>\r\n')
	file.store_string('            <!-- timeStep SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')
	
func _parse_hkbEventsFromRangeModifier(file, node): # Done
	file.store_string('        <hkobject class="hkbEventsFromRangeModifier" name="#' + str(node.nodeID) + '" signature="0xc9ece705">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="enable">' + str(node.enable) + '</hkparam>\r\n')
	file.store_string('            <!-- padModifier1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="inputValue">' + str(node.inputValue) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="lowerBound">' + str(node.lowerBound) + '</hkparam>\r\n')
	if node.nodeConnection1.size() != 0:
		file.store_string('            <hkparam name="eventRanges">#' + str(node.nodeConnection1[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="eventRanges">null</hkparam>\r\n')
	file.store_string('            <!-- wasActiveInPreviousFrame SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbEventRangeDataArray(file, node, nodeExportIndex, transitionArrayLength):
	file.store_string('        <hkobject class="hkbEventRangeDataArray" name="#' + str(node.nodeID) + '" signature="0x83502c2d">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="eventData" numelements="'+ str(node.rangeArray.size()) +'">\r\n')
	for rangeData in node.rangeArray:
		file.store_string('                <hkobject>\r\n')
		file.store_string('                    <hkparam name="upperBound">' + str(rangeData.upperBound) + '</hkparam>\r\n')
		file.store_string('                    <hkparam name="event">\r\n')
		file.store_string('                        <hkobject class="hkbEventProperty" name="event" signature="0xdb38a15">\r\n')
		file.store_string('                            <hkparam name="id">' + str(rangeData.eventID) + '</hkparam>\r\n')
		if rangeData.payloadID != null && rangeData.payloadID != -1:
			file.store_string('                            <hkparam name="payload">#' + str(nodeExportIndex + rangeData.payloadID + transitionArrayLength) + '</hkparam>\r\n')
		else:
			file.store_string('                            <hkparam name="payload">null</hkparam>\r\n')
		file.store_string('                        </hkobject>\r\n')
		file.store_string('                    </hkparam>\r\n')
		if rangeData.eventMode == 0:
			file.store_string('                    <hkparam name="eventMode">EVENT_MODE_SEND_ON_ENTER_RANGE</hkparam>\r\n')
		else:
			file.store_string('                    <hkparam name="eventMode">EVENT_MODE_SEND_WHEN_IN_RANGE</hkparam>\r\n')
		file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_BSBehaviorGraphSwapGenerator(file, node):
	file.store_string('        <hkobject class="BSBehaviorGraphSwapGenerator" name="#' + str(node.nodeID) + '" signature="0xe7633191">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- partitionInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- syncInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad4 SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection1.size() != 0:
		file.store_string('            <hkparam name="pDefaultGenerator">#' + str(node.nodeConnection1[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="pDefaultGenerator">null</hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_BSRagdollContactListenerModifier(file):
	print()

func _parse_hkbBehaviorGraphData(file, variableArray, eventArray, propertiesArray, nodeExportIndex): # Done
	file.store_string('        <hkobject class="hkbBehaviorGraphData" name="#' + str(nodeExportIndex) + '" signature="0x907a8222">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="attributeDefaults" numelements="0"/>\r\n')
	
	if variableArray.size() == 0:
		file.store_string('            <hkparam name="variableInfos" numelements="0"/>\r\n')
	else:
		file.store_string('            <hkparam name="variableInfos" numelements="' + str(variableArray.size()) + '">\r\n')
		for variable in variableArray:
			file.store_string('                <hkobject>\r\n')
			file.store_string('                    <hkparam name="role">\r\n')
			file.store_string('                        <hkobject class="hkbRoleAttribute" name="role" signature="0xfecef669">\r\n')
			file.store_string('                            <hkparam name="role">ROLE_DEFAULT</hkparam>\r\n')
			file.store_string('                            <hkparam name="flags">FLAG_NONE</hkparam>\r\n')
			file.store_string('                        </hkobject>\r\n')
			file.store_string('                    </hkparam>\r\n')
			match variable.variableType:
				0:
					file.store_string('                    <hkparam name="type">VARIABLE_TYPE_BOOL</hkparam>\r\n')
				1:
					file.store_string('                    <hkparam name="type">VARIABLE_TYPE_INT8</hkparam>\r\n')
				2:
					file.store_string('                    <hkparam name="type">VARIABLE_TYPE_INT16</hkparam>\r\n')
				3:
					file.store_string('                    <hkparam name="type">VARIABLE_TYPE_INT32</hkparam>\r\n')
				4:
					file.store_string('                    <hkparam name="type">VARIABLE_TYPE_REAL</hkparam>\r\n')
				5:
					file.store_string('                    <hkparam name="type">VARIABLE_TYPE_POINTER</hkparam>\r\n')
				6:
					file.store_string('                    <hkparam name="type">VARIABLE_TYPE_VECTOR4</hkparam>\r\n')
				7:
					file.store_string('                    <hkparam name="type">VARIABLE_TYPE_QUATERNION</hkparam>\r\n')
			file.store_string('                </hkobject>\r\n')
		file.store_string('            </hkparam>\r\n')
	
	if propertiesArray.size() == 0:
		file.store_string('            <hkparam name="characterPropertyInfos" numelements="0"/>\r\n')
	else:
		file.store_string('            <hkparam name="characterPropertyInfos" numelements="' + str(propertiesArray.size()) + '">\r\n')
		for properties in propertiesArray:
			file.store_string('                <hkobject>\r\n')
			file.store_string('                    <hkparam name="role">\r\n')
			file.store_string('                        <hkobject class="hkbRoleAttribute" name="role" signature="0xfecef669">\r\n')
			file.store_string('                            <hkparam name="role">ROLE_DEFAULT</hkparam>\r\n')
			file.store_string('                            <hkparam name="flags">FLAG_NONE</hkparam>\r\n')
			file.store_string('                        </hkobject>\r\n')
			file.store_string('                    </hkparam>\r\n')
			match properties.propertiesType:
				0:
					file.store_string('                    <hkparam name="type">VARIABLE_TYPE_BOOL</hkparam>\r\n')
				1:
					file.store_string('                    <hkparam name="type">VARIABLE_TYPE_INT8</hkparam>\r\n')
				2:
					file.store_string('                    <hkparam name="type">VARIABLE_TYPE_INT16</hkparam>\r\n')
				3:
					file.store_string('                    <hkparam name="type">VARIABLE_TYPE_INT32</hkparam>\r\n')
				4:
					file.store_string('                    <hkparam name="type">VARIABLE_TYPE_REAL</hkparam>\r\n')
				5:
					file.store_string('                    <hkparam name="type">VARIABLE_TYPE_POINTER</hkparam>\r\n')
				6:
					file.store_string('                    <hkparam name="type">VARIABLE_TYPE_VECTOR4</hkparam>\r\n')
				7:
					file.store_string('                    <hkparam name="type">VARIABLE_TYPE_QUATERNION</hkparam>\r\n')
			file.store_string('                </hkobject>\r\n')
		file.store_string('            </hkparam>\r\n')
	
	if eventArray.size() == 0:
		file.store_string('            <hkparam name="eventInfos" numelements="0"/>\r\n')
	else:
		file.store_string('            <hkparam name="eventInfos" numelements="' + str(eventArray.size()) + '">\r\n')
		for event in eventArray:
				file.store_string('                <hkobject>\r\n')
				if event.eventFlags == 0:
					file.store_string('                    <hkparam name="flags">0</hkparam>\r\n')
				else:
					file.store_string('                    <hkparam name="flags">FLAG_SYNC_POINT</hkparam>\r\n')
				file.store_string('                </hkobject>\r\n')
		file.store_string('            </hkparam>\r\n')
	file.store_string('            <hkparam name="variableBounds" numelements="0"/>\r\n')
	# TODO: Fix Boundaries Bug
	#if variableArray.size() == 0:
		#file.store_string('            <hkparam name="variableBounds" numelements="0"/>\r\n')
	#else:
		#file.store_string('            <hkparam name="variableBounds" numelements="' + str(variableArray.size()) + '">\r\n')
		#for variable in variableArray:
				#file.store_string('                <hkobject>\r\n')
				#file.store_string('                    <hkparam name="min">\r\n')
				#file.store_string('                        <hkobject class="hkbVariableValue" name="min" signature="0xb99bd6a">\r\n')
				#file.store_string('                            <hkparam name="value">' + str(variable.variableMinValue) + '</hkparam>\r\n')
				#file.store_string('                        </hkobject>\r\n')
				#file.store_string('                    </hkparam>\r\n')
				#file.store_string('                    <hkparam name="max">\r\n')
				#file.store_string('                        <hkobject class="hkbVariableValue" name="max" signature="0xb99bd6a">\r\n')
				#file.store_string('                            <hkparam name="value">' + str(variable.variableMaxValue) + '</hkparam>\r\n')
				#file.store_string('                        </hkobject>\r\n')
				#file.store_string('                    </hkparam>\r\n')
				#file.store_string('                </hkobject>\r\n')
		#file.store_string('            </hkparam>\r\n')
	
	file.store_string('            <hkparam name="variableInitialValues">#' + str(nodeExportIndex + 1) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="stringData">#' + str(nodeExportIndex + 2) + '</hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbVariableValueSet(file, variableArray, nodeExportIndex): # Done
	var quadValuesArray = []
	var pointerCounter = 0
	file.store_string('        <hkobject class="hkbVariableValueSet" name="#' + str(nodeExportIndex) +'" signature="0xeb5f7e25">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if variableArray.size():
		file.store_string('            <hkparam name="wordVariableValues" numelements="' + str(variableArray.size()) + '">\r\n')
		for variable in variableArray:
			if variable.variableType == 5:
				pointerCounter += 1
			if variable.variableType == 6 || variable.variableType == 7:
				quadValuesArray.append(variable.variableQuadValues)
			file.store_string('                <hkobject>\r\n')
			file.store_string('                    <hkparam name="value">' + str(variable.variableValue) + '</hkparam>\r\n')
			file.store_string('                </hkobject>\r\n')
		file.store_string('            </hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="wordVariableValues" numelements="0"/>\r\n')
	if quadValuesArray.size():
		file.store_string('            <hkparam name="quadVariableValues" numelements="' + str(quadValuesArray.size()) + '">\r\n')
		for quadValue in quadValuesArray:
				file.store_string('            ' + str(quadValue) + '\r\n')
		file.store_string('            </hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="quadVariableValues" numelements="0"/>\r\n')
	file.store_string('            <hkparam name="variantVariableValues" numelements="' + str(pointerCounter) + '">\r\n')
	for pointer in pointerCounter:
			file.store_string('            null\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')
	
func _parse_hkbBehaviorGraphStringData(file, variableArray, eventArray, propertiesArray, nodeExportIndex): # Done
	file.store_string('        <hkobject class="hkbBehaviorGraphStringData" name="#' + str(nodeExportIndex) + '" signature="0x1bd27f38">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if eventArray.size() != 0:
		file.store_string('            <hkparam name="eventNames" numelements="' + str(eventArray.size()) + '">\r\n')
		for event in eventArray:
			file.store_string('                <hkcstring>' + str(event.eventName) + '</hkcstring>\r\n')
		file.store_string('            </hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="eventNames" numelements="0"/>\r\n')
	file.store_string('            <hkparam name="attributeNames" numelements="0"/>\r\n')
	if variableArray.size() != 0:
		file.store_string('            <hkparam name="variableNames" numelements="' + str(variableArray.size()) + '">\r\n')
		for variable in variableArray:
			file.store_string('                <hkcstring>' + str(variable.variableName) + '</hkcstring>\r\n')
		file.store_string('            </hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableNames" numelements="0"/>\r\n')
	if propertiesArray.size() != 0:
		file.store_string('            <hkparam name="characterPropertyNames" numelements="' + str(propertiesArray.size()) + '">\r\n')
		for properties in propertiesArray:
			file.store_string('                <hkcstring>' + str(properties.propertiesName) + '</hkcstring>\r\n')
		file.store_string('            </hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="characterPropertyNames" numelements="0"/>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_BGSGamebryoSequenceGenerator(file, node): # Done
	file.store_string('        <hkobject class="BGSGamebryoSequenceGenerator" name="#' + str(node.nodeID) + '" signature="0x4e708fb6">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- partitionInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- syncInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad4 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="pSequence">' + str(node.pSequence) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="eBlendModeFunction">' + str(node.eBlendModeFunction) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="fPercent">' + str(node.fPercent) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="eUseTimePercentage">' + str(node.eUseTimePercentage) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="fTimePercent">' + str(node.fTimePercent) + '</hkparam>\r\n')
	file.store_string('            <!-- events SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- fTime SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- bDelayedActivate SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- bLooping SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbStringEventPayload(file, payload, nodeExportIndex): # Done
	file.store_string('        <hkobject class="hkbStringEventPayload" name="#' + str(nodeExportIndex) + '" signature="0xdf5fe694">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="data">' + str(payload.payloadName) + '</hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbReferencePoseGenerator(file, node): # Done
	file.store_string('        <hkobject class="hkbReferencePoseGenerator" name="#' + str(node.nodeID) + '" signature="0xbc1536ee">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- partitionInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- syncInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad4 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- skeleton SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbBehaviorReferenceGenerator(file, node): # Done
	file.store_string('        <hkobject class="hkbBehaviorReferenceGenerator" name="#' + str(node.nodeID) + '" signature="0x154fcfaa">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- partitionInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- syncInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad4 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="behaviorName">' + str(node.behaviorName) + '</hkparam>\r\n')
	file.store_string('            <!-- behavior SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_BSAssignVariablesModifier(file, node): # Done
	file.store_string('        <hkobject class="BSAssignVariablesModifier" name="#' + str(node.nodeID) + '" signature="0x64a6ca08">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="enable">' + str(node.enable) + '</hkparam>\r\n')
	file.store_string('            <!-- padModifier1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="floatVariable1">' + str(node.floatVariable[0]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue1">' + str(node.floatValue[0]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable2">' + str(node.floatVariable[1]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue2">' + str(node.floatValue[1]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable3">' + str(node.floatVariable[2]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue3">' + str(node.floatValue[2]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable4">' + str(node.floatVariable[3]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue4">' + str(node.floatValue[3]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable5">' + str(node.floatVariable[4]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue5">' + str(node.floatValue[4]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable6">' + str(node.floatVariable[5]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue6">' + str(node.floatValue[5]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable7">' + str(node.floatVariable[6]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue7">' + str(node.floatValue[6]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable8">' + str(node.floatVariable[7]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue8">' + str(node.floatValue[7]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable9">' + str(node.floatVariable[8]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue9">' + str(node.floatValue[8]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable10">' + str(node.floatVariable[9]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue10">' + str(node.floatValue[9]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable11">' + str(node.floatVariable[10]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue11">' + str(node.floatValue[10]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable12">' + str(node.floatVariable[11]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue12">' + str(node.floatValue[11]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable13">' + str(node.floatVariable[12]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue13">' + str(node.floatValue[12]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable14">' + str(node.floatVariable[13]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue14">' + str(node.floatValue[13]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable15">' + str(node.floatVariable[14]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue15">' + str(node.floatValue[14]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable16">' + str(node.floatVariable[15]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue16">' + str(node.floatValue[15]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable17">' + str(node.floatVariable[16]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue17">' + str(node.floatValue[16]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable18">' + str(node.floatVariable[17]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue18">' + str(node.floatValue[17]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable19">' + str(node.floatVariable[18]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue19">' + str(node.floatValue[18]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatVariable20">' + str(node.floatVariable[19]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="floatValue20">' + str(node.floatValue[19]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="intVariable1">' + str(node.intVariable[0]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="intValue1">' + str(node.intValue[0]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="intVariable2">' + str(node.intVariable[1]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="intValue2">' + str(node.intValue[1]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="intVariable3">' + str(node.intVariable[2]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="intValue3">' + str(node.intValue[2]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="intVariable4">' + str(node.intVariable[3]) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="intValue4">' + str(node.intValue[3]) + '</hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_DynamicAnimationTaggingGenerator(file, node): # Done
	file.store_string('        <hkobject class="DynamicAnimationTaggingGenerator" name="#' + str(node.nodeID) + '" signature="0xe7633191">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- partitionInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- syncInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad4 SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection1.size() != 0:
		file.store_string('            <hkparam name="pDefaultGenerator">#' + str(node.nodeConnection1[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="pDefaultGenerator">null</hkparam>\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_BSTimerModifier(file, node, nodeExportIndex, transitionArrayLength): # Done
	file.store_string('        <hkobject class="BSTimerModifier" name="#' + str(node.nodeID) + '" signature="0x9266ffac">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="enable">' + str(node.enable) + '</hkparam>\r\n')
	file.store_string('            <!-- padModifier1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- padModifier3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="alarmTimeSeconds">' + str(node.alarmTimeSeconds) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="alarmEvent">\r\n')
	file.store_string('                <hkobject class="hkbEventProperty" name="alarmEvent" signature="0xdb38a15">\r\n')
	if node.eventId != -1:
		file.store_string('                    <hkparam name="id">' + str(node.eventId) + '</hkparam>\r\n')
	else:
		file.store_string('                    <hkparam name="id">-1</hkparam>\r\n')
	if node.payload != -1:
		file.store_string('                    <hkparam name="payload">#' + str(nodeExportIndex + node.payload + transitionArrayLength) + '</hkparam>\r\n')
	else:
		file.store_string('                    <hkparam name="payload">null</hkparam>\r\n')
	file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('            <hkparam name="resetAlarm">' + str(node.resetAlarm) + '</hkparam>\r\n')
	file.store_string('            <!-- secondsElapsed SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_BSCyclicBlendTransitionGenerator(file, node, nodeExportIndex, transitionArrayLength):
	file.store_string('        <hkobject class="BSCyclicBlendTransitionGenerator" name="#' + str(node.nodeID) + '" signature="0x86401931">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- partitionInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- syncInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad4 SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection1.size() != 0:
		file.store_string('            <hkparam name="pBlenderGenerator">#' + str(node.nodeConnection1[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="pBlenderGenerator">null</hkparam>\r\n')
	file.store_string('            <hkparam name="EventToFreezeBlendValue">\r\n')
	file.store_string('                <hkobject class="hkbEventProperty" name="EventToFreezeBlendValue" signature="0xdb38a15">\r\n')
	file.store_string('                    <hkparam name="id">' + str(node.EventToFreezeBlendValueID) + '</hkparam>\r\n')
	if node.EventToFreezeBlendValuePayload != -1:
		file.store_string('                    <hkparam name="payload">#' + str(nodeExportIndex + node.EventToFreezeBlendValuePayload + transitionArrayLength) + '</hkparam>\r\n')
	else:
		file.store_string('                    <hkparam name="payload">null</hkparam>\r\n')
	file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('            <hkparam name="EventToCrossBlend">\r\n')
	file.store_string('                <hkobject class="hkbEventProperty" name="EventToCrossBlend" signature="0xdb38a15">\r\n')
	file.store_string('                    <hkparam name="id">' + str(node.EventToCrossBlendID) + '</hkparam>\r\n')
	if node.EventToCrossBlendPayload != -1:
		file.store_string('                    <hkparam name="payload">#' + str(nodeExportIndex + node.EventToCrossBlendPayload + transitionArrayLength) + '</hkparam>\r\n')
	else:
		file.store_string('                    <hkparam name="payload">null</hkparam>\r\n')
	file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('            <hkparam name="TransitionOutEvent">\r\n')
	file.store_string('                <hkobject class="hkbEventProperty" name="TransitionOutEvent" signature="0xdb38a15">\r\n')
	file.store_string('                    <hkparam name="id">' + str(node.TransitionOutEventID) + '</hkparam>\r\n')
	if node.TransitionOutEventPayload != -1:
		file.store_string('                    <hkparam name="payload">#' + str(nodeExportIndex + node.TransitionOutEventPayload + transitionArrayLength) + '</hkparam>\r\n')
	else:
		file.store_string('                    <hkparam name="payload">null</hkparam>\r\n')
	file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('            <hkparam name="TransitionInEvent">\r\n')
	file.store_string('                <hkobject class="hkbEventProperty" name="TransitionInEvent" signature="0xdb38a15">\r\n')
	file.store_string('                    <hkparam name="id">' + str(node.TransitionInEventID) + '</hkparam>\r\n')
	if node.TransitionInEventPayload != -1:
		file.store_string('                    <hkparam name="payload">#' + str(nodeExportIndex + node.TransitionInEventPayload + transitionArrayLength) + '</hkparam>\r\n')
	else:
		file.store_string('                    <hkparam name="payload">null</hkparam>\r\n')
	file.store_string('                </hkobject>\r\n')
	file.store_string('            </hkparam>\r\n')
	file.store_string('            <hkparam name="fBlendParameter">0.0</hkparam>\r\n')
	file.store_string('            <hkparam name="fTransitionDuration">' + str(node.fTransitionDuration) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="eBlendCurve">0</hkparam>\r\n')
	file.store_string('            <!-- pTransitionBlenderGeneratorsA SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- sortedChildren SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pTempOutput SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- currentMode SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')

func _parse_hkbGeneratorTransitionEffect(file, node):
	file.store_string('        <hkobject class="hkbGeneratorTransitionEffect" name="#' + str(node.nodeID) + '" signature="0x44208f07">\r\n')
	file.store_string('            <!-- memSizeAndRefCount SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection0.size() != 0:
		file.store_string('            <hkparam name="variableBindingSet">#' + str(node.nodeConnection0[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="variableBindingSet">null</hkparam>\r\n')
	file.store_string('            <!-- cachedBindables SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- areBindablesCached SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- hasEnableChanged SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <hkparam name="userData">' + str(node.userData) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="name">' + str(node.nodeName) + '</hkparam>\r\n')
	file.store_string('            <!-- id SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- cloneState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- type SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- nodeInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- partitionInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- syncInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad1 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad2 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad3 SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- pad4 SERIALIZE_IGNORED -->\r\n')
	if node.selfTransitionMode == 1:
		file.store_string('            <hkparam name="selfTransitionMode">SELF_TRANSITION_MODE_CONTINUE</hkparam>\r\n')
	elif node.selfTransitionMode == 2:
		file.store_string('            <hkparam name="selfTransitionMode">SELF_TRANSITION_MODE_RESET</hkparam>\r\n')
	elif node.selfTransitionMode == 3:
		file.store_string('            <hkparam name="selfTransitionMode">SELF_TRANSITION_MODE_BLEND</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="selfTransitionMode">SELF_TRANSITION_MODE_CONTINUE_IF_CYCLIC_BLEND_IF_ACYCLIC</hkparam>\r\n')
	if node.eventMode == 1:
		file.store_string('            <hkparam name="eventMode">EVENT_MODE_PROCESS_ALL</hkparam>\r\n')
	elif node.eventMode == 2:
		file.store_string('            <hkparam name="eventMode">EVENT_MODE_IGNORE_FROM_GENERATOR</hkparam>\r\n')
	elif node.eventMode == 3:
		file.store_string('            <hkparam name="eventMode">EVENT_MODE_IGNORE_TO_GENERATOR</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="eventMode">EVENT_MODE_DEFAULT</hkparam>\r\n')
	file.store_string('            <!-- defaultEventMode SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- patchedBindingInfo SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- fromGenerator SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- toGenerator SERIALIZE_IGNORED -->\r\n')
	if node.nodeConnection1.size() != 0:
		file.store_string('            <hkparam name="transitionGenerator">#' + str(node.nodeConnection1[0][2]) + '</hkparam>\r\n')
	else:
		file.store_string('            <hkparam name="transitionGenerator">null</hkparam>\r\n')
	file.store_string('            <hkparam name="blendInDuration">' + str(node.blendInDuration) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="blendOutDuration">' + str(node.blendOutDuration) + '</hkparam>\r\n')
	file.store_string('            <hkparam name="syncToGeneratorStartTime">' + str(node.syncToGeneratorStartTime) + '</hkparam>\r\n')
	file.store_string('            <!-- childState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- timeInTransition SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- duration SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- effectiveBlendInDuration SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- effectiveBlendOutDuration SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- toGeneratorState SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- echoTransitionGenerator SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- toGeneratorSelfTransitionMode SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- justActivated SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- updateActiveNodes SERIALIZE_IGNORED -->\r\n')
	file.store_string('            <!-- stage SERIALIZE_IGNORED -->\r\n')
	file.store_string('        </hkobject>\r\n')
