extends Node


func _save_nodes(saveInfo, path):
	var node_file = FileAccess.open(path, FileAccess.WRITE)
	
	for saveData in saveInfo:
		var json_string = JSON.stringify(saveData)
		# Store the save dictionary as a new line in the save file.
		node_file.store_line(json_string)

func _load_nodes(path, graphEdit, nodeIndex):
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open(path, FileAccess.READ)
	
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
			# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		#globalTransitionList, globalEventList, globalPayloadList, globalPropertiesList, globalVariableList
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var transitionList = []
		for transition in json.get_data():
			transitionList.append(transition)

		# Events
		json_string = save_file.get_line()
		json = JSON.new()
		parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var eventList = []
		for event in json.get_data():
			eventList.append(event)

		# Event Payloads
		json_string = save_file.get_line()
		json = JSON.new()
		parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var payloadList = []
		for payload in json.get_data():
			payloadList.append(payload)

		# Properties
		json_string = save_file.get_line()
		json = JSON.new()
		parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var propertiesList = []
		for property in json.get_data():
			propertiesList.append(property)

		# Variables
		json_string = save_file.get_line()
		json = JSON.new()
		parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var variableList = []
		for variable in json.get_data():
			variableList.append(variable)

		# Reloading Global Values
		graphEdit.get_parent()._load_global_values(transitionList, eventList, payloadList, propertiesList, variableList)

		# Nodes
		json_string = save_file.get_line()
		json = JSON.new()
		parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		for node in json.get_data():
			_node_processing(node, graphEdit, nodeIndex)
		json_string = save_file.get_line()
		json = JSON.new()
		parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		for connection in json.get_data():
			for from_node in graphEdit.get_children():
				if from_node.get("nodeID") == connection[1]:
					for to_node in graphEdit.get_children():
						if to_node.get("nodeID") == connection[2]:
							graphEdit.connect_node(str(from_node.name), connection[0], str(to_node.name), 0)
	return nodeIndex

func _node_processing(node, graphEdit, nodeIndex):
			match int(node.nodeTypeID):
				0:
					print("hkRootLevelContainer loaded.")
					var loadedNode = globalVariable.hkRootLevelContainer.instantiate()
					base_node_values(loadedNode, node)
					graphEdit.add_child(loadedNode)
				1:
					print("hkbBehaviorGraph loaded.")
					var loadedNode = globalVariable.hkbBehaviorGraph.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName = node.nodeName
					graphEdit.add_child(loadedNode)
				2:
					print("hkbBehaviorGraphData loaded.")
				3:
					print("hkbVariableValueSet loaded.")
				4:
					print("hkbBehaviorGraphStringData loaded.")
				5:
					print("hkbStateMachine loaded.")
					var loadedNode = globalVariable.hkbStateMachine.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName = node.nodeName
					loadedNode.userData = node.userData
					loadedNode.startStateId = node.startStateId
					loadedNode.randomTransitionEventId = node.randomTransitionEventId
					loadedNode.transitionToNextHigherStateEventId = node.transitionToNextHigherStateEventId
					loadedNode.transitionToNextLowerStateEventId = node.transitionToNextLowerStateEventId
					loadedNode.syncVariableIndex = node.syncVariableIndex
					loadedNode.wrapAroundStateId = node.wrapAroundStateId
					loadedNode.startStateMode = node.startStateMode
					loadedNode.selfTransitionMode = node.selfTransitionMode
					loadedNode.eventId = node.eventId
					loadedNode.payload = node.payload
					graphEdit.add_child(loadedNode)
				6:
					print("hkbStateMachineStateInfo loaded.")
					var loadedNode = globalVariable.hkbStateMachineStateInfo.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName = node.nodeName
					loadedNode.stateId = node.stateId
					loadedNode.probability = node.probability
					loadedNode.enable = node.enable
					graphEdit.add_child(loadedNode)
				7:
					print("hkbStateMachineTransitionInfoArray loaded.")
					var loadedNode = globalVariable.hkbStateMachineTransitionInfoArray.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.transitionArray = node.transitionArray
					graphEdit.add_child(loadedNode)
				8:
					print("hkbStateMachineEventPropertyArray loaded.")
					var loadedNode = globalVariable.hkbStateMachineEventPropertyArray.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.eventsArray = node.eventsArray
					graphEdit.add_child(loadedNode)
				9:
					print("hkbModifierGenerator loaded.")
					var loadedNode = globalVariable.hkbModifierGenerator.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName = node.nodeName
					loadedNode.userData = node.userData
					graphEdit.add_child(loadedNode)
				10:
					print("hkbModifierList loaded.")
					var loadedNode = globalVariable.hkbModifierList.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName					= node.nodeName
					loadedNode.userData					= node.userData
					loadedNode.enable					= node.enable
					graphEdit.add_child(loadedNode)
				11:
					print("hkbGetUpModifier loaded.")
					var loadedNode = globalVariable.hkbGetUpModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName					= node.nodeName
					loadedNode.userData					= node.userData
					loadedNode.enable					= node.enable
					loadedNode.groundNormal				= node.groundNormal
					loadedNode.duration					= node.duration
					loadedNode.alignWithGroundDuration	= node.alignWithGroundDuration
					loadedNode.rootBoneIndex			= node.rootBoneIndex
					loadedNode.otherBoneIndex			= node.otherBoneIndex
					loadedNode.anotherBoneIndex			= node.anotherBoneIndex
					graphEdit.add_child(loadedNode)
				12:
					print("hkbKeyframeBonesModifier loaded.")
					var loadedNode = globalVariable.hkbKeyframeBonesModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.enable				= node.enable
					loadedNode.nodeName					= node.nodeName
					loadedNode.userData				= node.userData
					graphEdit.add_child(loadedNode)
				13:
					print("hkbBoneIndexArray loaded.")
					var loadedNode = globalVariable.hkbBoneIndexArray.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.boneIndices				= node.boneIndices
					graphEdit.add_child(loadedNode)
				14:
					print("hkbBoneWeightArray loaded.")
					var loadedNode = globalVariable.hkbBoneWeightArray.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.boneWeights				= node.boneWeights
					graphEdit.add_child(loadedNode)
				15:
					print("hkbRigidBodyRagdollControlsModifier loaded.")
					var loadedNode = globalVariable.hkbRigidBodyRagdollControlsModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.enable				= node.enable
					loadedNode.userData				= node.userData
					loadedNode.nodeName					= node.nodeName
					loadedNode.hierarchyGain = node.hierarchyGain
					loadedNode.velocityDamping = node.velocityDamping
					loadedNode.accelerationGain = node.accelerationGain
					loadedNode.velocityGain = node.velocityGain
					loadedNode.positionGain = node.positionGain
					loadedNode.positionMaxLinearVelocity = node.positionMaxLinearVelocity
					loadedNode.positionMaxAngularVelocity = node.positionMaxAngularVelocity
					loadedNode.snapGain = node.snapGain
					loadedNode.snapMaxLinearVelocity = node.snapMaxLinearVelocity
					loadedNode.snapMaxAngularVelocity = node.snapMaxAngularVelocity
					loadedNode.snapMaxLinearDistance = node.snapMaxLinearDistance
					loadedNode.snapMaxAngularDistance = node.snapMaxAngularDistance
					loadedNode.durationToBlend = node.durationToBlend
					loadedNode.animationBlendFraction = node.animationBlendFraction
					graphEdit.add_child(loadedNode)
				16:
					print("BSIsActiveModifier loaded.")
					var loadedNode = globalVariable.BSIsActiveModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName				= node.nodeName
					loadedNode.enable				= node.enable
					loadedNode.userData				= node.userData
					loadedNode.bIsActiveArray		= node.bIsActiveArray
					graphEdit.add_child(loadedNode)
				17:
					print("hkbVariableBindingSet loaded.")
					var loadedNode = globalVariable.hkbVariableBindingSet.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.bindingArray				= node.bindingArray
					loadedNode.indexOfBindingToEnable	= node.indexOfBindingToEnable
					graphEdit.add_child(loadedNode)
				18:
					print("hkbManualSelectorGenerator loaded.")
					var loadedNode = globalVariable.hkbManualSelectorGenerator.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.enable									= node.enable
					loadedNode.userData									= node.userData
					loadedNode.nodeName									= node.nodeName
					loadedNode.selectedGeneratorIndex					= node.selectedGeneratorIndex
					loadedNode.selectedIndexCanChangeAfterActivate 		= node.selectedIndexCanChangeAfterActivate
					loadedNode.generatorChangedTransitionEffect 		= node.generatorChangedTransitionEffect
					graphEdit.add_child(loadedNode)
				19:
					print("BSModifyOnceModifier loaded.")
					var loadedNode = globalVariable.BSModifyOnceModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.enable									= node.enable
					loadedNode.nodeName									= node.nodeName
					loadedNode.userData									= node.userData
					graphEdit.add_child(loadedNode)
				20:
					print("hkbEvaluateExpressionModifier loaded.")
					var loadedNode = globalVariable.hkbEvaluateExpressionModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.enable									= node.enable
					loadedNode.nodeName									= node.nodeName
					loadedNode.userData									= node.userData
					graphEdit.add_child(loadedNode)
				21:
					print("hkbExpressionDataArray loaded.")
					var loadedNode = globalVariable.hkbExpressionDataArray.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.expressionArray							= node.expressionArray
					graphEdit.add_child(loadedNode)
				22:
					print("hkbPoseMatchingGenerator loaded.")
					var loadedNode = globalVariable.hkbPoseMatchingGenerator.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName = node.nodeName
					loadedNode.userData = node.userData
					loadedNode.blendParameter = node.blendParameter
					loadedNode.blendSpeed = node.blendSpeed
					loadedNode.minSpeedToSwitch = node.minSpeedToSwitch
					loadedNode.startPlayingEventId = node.startPlayingEventId
					loadedNode.startMatchingEventId = node.startMatchingEventId
					loadedNode.rootBoneIndex = node.rootBoneIndex
					loadedNode.otherBoneIndex = node.otherBoneIndex
					loadedNode.anotherBoneIndex = node.anotherBoneIndex
					loadedNode.pelvisIndex = node.pelvisIndex
					graphEdit.add_child(loadedNode)
				23:
					print("hkbBlenderGenerator loaded.")
					var loadedNode = globalVariable.hkbBlenderGenerator.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName									= node.nodeName
					loadedNode.userData									= node.userData
					loadedNode.blendParameter							= node.blendParameter
					loadedNode.maxCyclicBlendParameter					= node.maxCyclicBlendParameter
					loadedNode.indexOfSyncMasterChild					= node.indexOfSyncMasterChild
					loadedNode.flagsIndex								= node.flagsIndex
					graphEdit.add_child(loadedNode)
				24:
					print("hkbBlenderGeneratorChild loaded.")
					var loadedNode = globalVariable.hkbBlenderGeneratorChild.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.weight				 = node.weight
					loadedNode.worldFromModelWeight	 = node.worldFromModelWeight
					graphEdit.add_child(loadedNode)
				25:
					print("hkbClipGenerator loaded.")
					var loadedNode = globalVariable.hkbClipGenerator.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName						 = node.nodeName
					loadedNode.userData						 = node.userData
					loadedNode.animationName				 = node.animationName
					loadedNode.cropStartAmountLocalTime		 = node.cropStartAmountLocalTime
					loadedNode.cropEndAmountLocalTime		 = node.cropEndAmountLocalTime
					loadedNode.startTime					 = node.startTime
					loadedNode.playbackSpeed				 = node.playbackSpeed
					loadedNode.enforcedDuration				 = node.enforcedDuration
					loadedNode.userControlledTimeFraction	 = node.userControlledTimeFraction
					loadedNode.mode							 = node.mode
					loadedNode.flagsIndex					 = node.flagsIndex
					graphEdit.add_child(loadedNode)
				26:
					print("hkbClipTriggerArray loaded.")
					var loadedNode = globalVariable.hkbClipTriggerArray.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.triggersArray = node.triggersArray
					graphEdit.add_child(loadedNode)
				27:
					print("hkbBlendingTransitionEffect loaded.")
				28:
					print("hkbEventDrivenModifier loaded.")
					var loadedNode = globalVariable.hkbEventDrivenModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.enable			 = node.enable
					loadedNode.nodeName			 = node.nodeName
					loadedNode.userData			 = node.userData
					loadedNode.activateEventId 	 = node.activateEventId
					loadedNode.deactivateEventId = node.deactivateEventId
					loadedNode.activeByDefault	 = node.activeByDefault
					graphEdit.add_child(loadedNode)
				29:
					print("hkbPoweredRagdollControlsModifier loaded.")
					var loadedNode = globalVariable.hkbPoweredRagdollControlsModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.enable						= node.enable
					loadedNode.nodeName						= node.nodeName
					loadedNode.userData						= node.userData
					loadedNode.maxForce						= node.maxForce
					loadedNode.tau							= node.tau
					loadedNode.damping 						= node.damping
					loadedNode.proportionalRecoveryVelocity = node.proportionalRecoveryVelocity
					loadedNode.constantRecoveryVelocity		= node.constantRecoveryVelocity
					loadedNode.poseMatchingBone0 			= node.poseMatchingBone0
					loadedNode.poseMatchingBone1 			= node.poseMatchingBone1
					loadedNode.poseMatchingBone2 			= node.poseMatchingBone2
					loadedNode.mode							= node.mode
					loadedNode.animationBlendFraction		= node.animationBlendFraction
					graphEdit.add_child(loadedNode)
				30:
					print("hkbTimerModifier loaded.")
					var loadedNode = globalVariable.hkbTimerModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName				= node.nodeName
					loadedNode.enable				= node.enable
					loadedNode.userData				= node.userData
					loadedNode.alarmTimeSeconds		= node.alarmTimeSeconds
					loadedNode.eventId 				= node.eventId
					loadedNode.payload				= node.payload
					graphEdit.add_child(loadedNode)
				31:
					print("BSLookAtModifier loaded.")
				32:
					print("BSGetTimeStepModifier loaded.")
					var loadedNode = globalVariable.BSGetTimeStepModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName				= node.nodeName
					loadedNode.enable				= node.enable
					loadedNode.userData				= node.userData
					loadedNode.timeStep				= node.timeStep
					graphEdit.add_child(loadedNode)
				33:
					print("hkbTwistModifier loaded.")
					var loadedNode = globalVariable.hkbTwistModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName					 = node.nodeName
					loadedNode.enable					 = node.enable
					loadedNode.userData					 = node.userData
					loadedNode.axisOfRotation			 = node.axisOfRotation
					loadedNode.twistAngle				 = node.twistAngle
					loadedNode.startBoneIndex			 = node.startBoneIndex
					loadedNode.endBoneIndex				 = node.endBoneIndex
					loadedNode.setAngleMethod			 = node.setAngleMethod
					loadedNode.rotationAxisCoordinates	 = node.rotationAxisCoordinates
					loadedNode.isAdditive				 = node.isAdditive
					graphEdit.add_child(loadedNode)
				34:
					print("BSInterpValueModifier loaded.")
					var loadedNode = globalVariable.BSInterpValueModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName					 = node.nodeName
					loadedNode.enable					 = node.enable
					loadedNode.userData					 = node.userData
					loadedNode.source					 = node.source
					loadedNode.target					 = node.target
					loadedNode.result					 = node.result
					loadedNode.gain						 = node.gain
					graphEdit.add_child(loadedNode)
				35:
					print("hkbEventsFromRangeModifier loaded.")
					var loadedNode = globalVariable.hkbEventsFromRangeModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName					 = node.nodeName
					loadedNode.enable					 = node.enable
					loadedNode.userData					 = node.userData
					loadedNode.inputValue				 = node.inputValue
					loadedNode.lowerBound				 = node.lowerBound
					graphEdit.add_child(loadedNode)
				36:
					print("hkbEventRangeDataArray loaded.")
					var loadedNode = globalVariable.hkbEventRangeDataArray.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.rangeArray				 = node.rangeArray
					graphEdit.add_child(loadedNode)
				37:
					print("BSBehaviorGraphSwapGenerator loaded.")
					var loadedNode = globalVariable.BSBehaviorGraphSwapGenerator.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName					 = node.nodeName
					loadedNode.userData					 = node.userData
					graphEdit.add_child(loadedNode)
				38:
					print("BSRagdollContactListenerModifier loaded.")
					var loadedNode = globalVariable.BSRagdollContactListenerModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName				= node.nodeName
					loadedNode.enable				= node.enable
					loadedNode.userData				= node.userData
					loadedNode.eventId 				= node.eventId
					loadedNode.payload				= node.payload
					graphEdit.add_child(loadedNode)
				39:
					print("BSCyclicBlendTransitionGenerator loaded.")
					var loadedNode = globalVariable.BSCyclicBlendTransitionGenerator.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName					 = node.nodeName
					loadedNode.userData					 = node.userData
					loadedNode.EventToFreezeBlendValueID	 	= node.EventToFreezeBlendValueID
					loadedNode.EventToFreezeBlendValuePayload	= node.EventToFreezeBlendValuePayload
					loadedNode.EventToCrossBlendID				 = node.EventToCrossBlendID
					loadedNode.EventToCrossBlendPayload			 = node.EventToCrossBlendPayload
					loadedNode.TransitionOutEventID				 = node.TransitionOutEventID
					loadedNode.TransitionOutEventPayload		 = node.TransitionOutEventPayload
					loadedNode.TransitionInEventID				 = node.TransitionInEventID
					loadedNode.TransitionInEventPayload			 = node.TransitionInEventPayload
					loadedNode.fTransitionDuration				 = node.fTransitionDuration
					graphEdit.add_child(loadedNode)
				40:
					print("BGSGamebryoSequenceGenerator loaded.")
					var loadedNode = globalVariable.BGSGamebryoSequenceGenerator.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName				= node.nodeName
					loadedNode.pSequence			= node.pSequence
					loadedNode.userData				= node.userData
					loadedNode.eBlendModeFunction	= node.eBlendModeFunction
					loadedNode.fPercent				= node.fPercent
					loadedNode.eUseTimePercentage	= node.eUseTimePercentage
					loadedNode.fTimePercent			= node.fTimePercent
					graphEdit.add_child(loadedNode)
				42:
					print("hkbBehaviorReferenceGenerator loaded.")
					var loadedNode = globalVariable.hkbBehaviorReferenceGenerator.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName				= node.nodeName
					loadedNode.userData				= node.userData
					loadedNode.behaviorName			= node.behaviorName
					graphEdit.add_child(loadedNode)
				43:
					print("BSAssignVariablesModifier loaded.")
					var loadedNode = globalVariable.BSAssignVariablesModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName				= node.nodeName
					loadedNode.userData				= node.userData
					loadedNode.enable				= node.enable
					loadedNode.floatVariable		= node.floatVariable
					loadedNode.floatValue			= node.floatValue
					loadedNode.intVariable			= node.intVariable
					loadedNode.intValue				= node.intValue
					graphEdit.add_child(loadedNode)
				44:
					print("DynamicAnimationTaggingGenerator loaded.")
					var loadedNode = globalVariable.DynamicAnimationTaggingGenerator.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName				= node.nodeName
					loadedNode.userData				= node.userData
					graphEdit.add_child(loadedNode)
				45:
					print("BSTimerModifier loaded.")
					var loadedNode = globalVariable.BSTimerModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName				= node.nodeName
					loadedNode.userData				= node.userData
					loadedNode.enable				= node.enable
					loadedNode.alarmTimeSeconds		= node.alarmTimeSeconds
					loadedNode.resetAlarm			= node.resetAlarm
					loadedNode.eventId				= node.eventId
					loadedNode.payload				= node.payload
					graphEdit.add_child(loadedNode)
				47:
					print("hkbGeneratorTransitionEffect loaded.")
					var loadedNode = globalVariable.hkbGeneratorTransitionEffect.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName					= node.nodeName
					loadedNode.userData					= node.userData
					loadedNode.selfTransitionMode		= node.selfTransitionMode
					loadedNode.eventMode				= node.eventMode
					loadedNode.blendInDuration			= node.blendInDuration
					loadedNode.blendOutDuration			= node.blendOutDuration
					loadedNode.syncToGeneratorStartTime	= node.syncToGeneratorStartTime
					graphEdit.add_child(loadedNode)
				48:
					print("hkbReferencePoseGenerator loaded.")
					var loadedNode = globalVariable.hkbReferencePoseGenerator.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName					= node.nodeName
					loadedNode.userData					= node.userData
					graphEdit.add_child(loadedNode)
				49:
					print("hkbDampingModifier loaded.")
					var loadedNode = globalVariable.hkbDampingModifier.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName					= node.nodeName
					loadedNode.userData					= node.userData
					loadedNode.enable					= node.enable
					loadedNode.kP						= node.kP
					loadedNode.kI						= node.kI
					loadedNode.kD						= node.kD
					loadedNode.enableScalarDamping		= node.enableScalarDamping
					loadedNode.enableVectorDamping		= node.enableVectorDamping
					loadedNode.rawValue					= node.rawValue
					loadedNode.dampedValue				= node.dampedValue
					loadedNode.rawVector				= node.rawVector
					loadedNode.dampedVector				= node.dampedVector
					loadedNode.vecErrorSum				= node.vecErrorSum
					loadedNode.vecPreviousError			= node.vecPreviousError
					loadedNode.errorSum					= node.errorSum
					loadedNode.previousError			= node.previousError
					graphEdit.add_child(loadedNode)
				50:
					print("hkbLayer loaded.")
					var loadedNode = globalVariable.hkbLayer.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.weight = node.weight
					loadedNode.worldFromModelWeight = node.worldFromModelWeight
					loadedNode.fadeInDuration = node.fadeInDuration
					loadedNode.fadeOutDuration = node.fadeOutDuration
					loadedNode.onEventId =node.onEventId
					loadedNode.offEventId =node.offEventId
					loadedNode.onByDefault =node.onByDefault
					loadedNode.useMotion = node.useMotion
					loadedNode.forceFullFadeDurations = node.forceFullFadeDurations
					graphEdit.add_child(loadedNode)
				51:
					print("hkbLayerGenerator loaded.")
					var loadedNode = globalVariable.hkbLayerGenerator.instantiate()
					base_node_values(loadedNode, node)
					loadedNode.nodeName									= node.nodeName
					loadedNode.userData									= node.userData
					loadedNode.indexOfSyncMasterChild					= node.indexOfSyncMasterChild
					loadedNode.flagsIndex								= node.flagsIndex
					graphEdit.add_child(loadedNode)
			if node.nodeID >= nodeIndex:
				nodeIndex = node.nodeID + 1

func base_node_values(loadedNode, node):
	loadedNode.title += ' - #' + str(node.nodeID)
	loadedNode.nodeID = node.nodeID
	loadedNode.position_offset = (string_to_vector2(str(node.nodePosition)))

func string_to_vector2(string := "") -> Vector2:
	if string:
		var new_string: String = string
		new_string = new_string.erase(0, 1)
		new_string = new_string.erase(new_string.length() - 1, 1)
		var array: Array = new_string.split(", ")
		return Vector2(int(array[0]), int(array[1]))
	return Vector2.ZERO
