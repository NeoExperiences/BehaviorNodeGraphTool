extends Node

func _load_XML(path, graphEdit):
	var parsedFile = XML.parse_file(path)
	var rootNode = parsedFile.root
	print("Root Node: ", rootNode.attributes)
	for root in rootNode.children:
		for object in root.children:
			print(object.attributes.name, " - ", object.attributes.class)
			_object_processing(object, graphEdit)
			print("[")
			for parameter in object.children:
				print("	", parameter.attributes.name, " = ", parameter.content)
				#if parameter.attributes.has("name"):
					#if parameter.attributes.name == "states":
						#var connections = parameter.content.split("#")
						#print("	", parameter.attributes.name, " = ")
						#for state in connections:
							#if state:
								#print("	", state.strip_edges())
					#else:
						#print("	", parameter.attributes.name, " = ", parameter.content)
				#elif parameter.attributes.has("numelements"):
					#for subparameter in parameter.children:
						#if subparameter.content == "":
							#for subparameter2 in subparameter.children:
								#print("		", subparameter2.attributes.name, " = ", subparameter2.content)
						#else:
							#print("		",subparameter.content)
				
			print("]")

func _object_processing(object, graphEdit):
			match object.attributes.class:
				"hkRootLevelContainer":
					print("hkRootLevelContainer loaded.")
					var loadedNode = globalVariable.hkRootLevelContainer.instantiate()
					base_node_values(loadedNode, object)
					graphEdit.add_child(loadedNode)
				"hkbBehaviorGraph":
					print("hkbBehaviorGraph loaded.")
					var loadedNode = globalVariable.hkbBehaviorGraph.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.nodeName = object.children[2].content
					graphEdit.add_child(loadedNode)
				#"hkbBehaviorGraphData":
					#print("hkbBehaviorGraphData loaded.")
				#"hkbVariableValueSet":
					#print("hkbVariableValueSet loaded.")
				#"hkbBehaviorGraphStringData":
					#print("hkbBehaviorGraphStringData loaded.")
				"hkbStateMachine":
					print("hkbStateMachine loaded.")
					var loadedNode = globalVariable.hkbStateMachine.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.startStateId = int(object.children[5].content)
					#loadedNode.randomTransitionEventId = node.randomTransitionEventId
					#loadedNode.transitionToNextHigherStateEventId = node.transitionToNextHigherStateEventId
					#loadedNode.transitionToNextLowerStateEventId = node.transitionToNextLowerStateEventId
					#loadedNode.syncVariableIndex = node.syncVariableIndex
					#loadedNode.wrapAroundStateId = node.wrapAroundStateId
					#loadedNode.startStateMode = node.startStateMode
					#loadedNode.selfTransitionMode = node.selfTransitionMode
					#loadedNode.eventId = node.eventId
					#loadedNode.payload = node.payload
					graphEdit.add_child(loadedNode)
				"hkbStateMachineStateInfo":
					print("hkbStateMachineStateInfo loaded.")
					var loadedNode = globalVariable.hkbStateMachineStateInfo.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.nodeName = object.children[6].content
					loadedNode.stateId = int(object.children[7].content)
					loadedNode.probability = object.children[8].content
					if object.children[9].content == "false":
						loadedNode.enable = false
					graphEdit.add_child(loadedNode)
				"hkbStateMachineTransitionInfoArray":
					print("hkbStateMachineTransitionInfoArray loaded.")
					var loadedNode = globalVariable.hkbStateMachineTransitionInfoArray.instantiate()
					base_node_values(loadedNode, object)
					#loadedNode.transitionArray = node.transitionArray
					graphEdit.add_child(loadedNode)
				"hkbStateMachineEventPropertyArray":
					print("hkbStateMachineEventPropertyArray loaded.")
					var loadedNode = globalVariable.hkbStateMachineEventPropertyArray.instantiate()
					base_node_values(loadedNode, object)
					#loadedNode.eventsArray = node.eventsArray
					graphEdit.add_child(loadedNode)
				"hkbModifierGenerator":
					print("hkbModifierGenerator loaded.")
					var loadedNode = globalVariable.hkbModifierGenerator.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					graphEdit.add_child(loadedNode)
				"hkbModifierList":
					print("hkbModifierList loaded.")
					var loadedNode = globalVariable.hkbModifierList.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					graphEdit.add_child(loadedNode)
				"hkbGetUpModifier":
					print("hkbGetUpModifier loaded.")
					var loadedNode = globalVariable.hkbGetUpModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					loadedNode.groundNormal				= object.children[4].content
					loadedNode.duration					= object.children[5].content
					loadedNode.alignWithGroundDuration	= object.children[6].content
					loadedNode.rootBoneIndex			= int(object.children[7].content)
					loadedNode.otherBoneIndex			= int(object.children[8].content)
					loadedNode.anotherBoneIndex		= int(object.children[9].content)
					graphEdit.add_child(loadedNode)
				"hkbKeyframeBonesModifier":
					print("hkbKeyframeBonesModifier loaded.")
					var loadedNode = globalVariable.hkbKeyframeBonesModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					graphEdit.add_child(loadedNode)
				"hkbBoneIndexArray":
					print("hkbBoneIndexArray loaded.")
					var loadedNode = globalVariable.hkbBoneIndexArray.instantiate()
					base_node_values(loadedNode, object)
					#loadedNode.boneIndices				= node.boneIndices
					graphEdit.add_child(loadedNode)
				"hkbBoneWeightArray":
					print("hkbBoneWeightArray loaded.")
					var loadedNode = globalVariable.hkbBoneWeightArray.instantiate()
					base_node_values(loadedNode, object)
					#loadedNode.boneWeights				= node.boneWeights
					graphEdit.add_child(loadedNode)
				"hkbRigidBodyRagdollControlsModifier":
					print("hkbRigidBodyRagdollControlsModifier loaded.")
					var loadedNode = globalVariable.hkbRigidBodyRagdollControlsModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					#loadedNode.hierarchyGain = node.hierarchyGain
					#loadedNode.velocityDamping = node.velocityDamping
					#loadedNode.accelerationGain = node.accelerationGain
					#loadedNode.velocityGain = node.velocityGain
					#loadedNode.positionGain = node.positionGain
					#loadedNode.positionMaxLinearVelocity = node.positionMaxLinearVelocity
					#loadedNode.positionMaxAngularVelocity = node.positionMaxAngularVelocity
					#loadedNode.snapGain = node.snapGain
					#loadedNode.snapMaxLinearVelocity = node.snapMaxLinearVelocity
					#loadedNode.snapMaxAngularVelocity = node.snapMaxAngularVelocity
					#loadedNode.snapMaxLinearDistance = node.snapMaxLinearDistance
					#loadedNode.snapMaxAngularDistance = node.snapMaxAngularDistance
					#loadedNode.durationToBlend = node.durationToBlend
					#loadedNode.animationBlendFraction = node.animationBlendFraction
					graphEdit.add_child(loadedNode)
				"BSIsActiveModifier":
					print("BSIsActiveModifier loaded.")
					var loadedNode = globalVariable.BSIsActiveModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					#loadedNode.bIsActiveArray		= node.bIsActiveArray
					graphEdit.add_child(loadedNode)
				"hkbVariableBindingSet":
					print("hkbVariableBindingSet loaded.")
					var loadedNode = globalVariable.hkbVariableBindingSet.instantiate()
					base_node_values(loadedNode, object)
					#loadedNode.bindingArray				= node.bindingArray
					#loadedNode.indexOfBindingToEnable	= node.indexOfBindingToEnable
					graphEdit.add_child(loadedNode)
				"hkbManualSelectorGenerator":
					print("hkbManualSelectorGenerator loaded.")
					var loadedNode = globalVariable.hkbManualSelectorGenerator.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					#loadedNode.selectedGeneratorIndex					= node.selectedGeneratorIndex
					#loadedNode.selectedIndexCanChangeAfterActivate 		= node.selectedIndexCanChangeAfterActivate
					#loadedNode.generatorChangedTransitionEffect 		= node.generatorChangedTransitionEffect
					graphEdit.add_child(loadedNode)
				"BSModifyOnceModifier":
					print("BSModifyOnceModifier loaded.")
					var loadedNode = globalVariable.BSModifyOnceModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					graphEdit.add_child(loadedNode)
				"hkbEvaluateExpressionModifier":
					print("hkbEvaluateExpressionModifier loaded.")
					var loadedNode = globalVariable.hkbEvaluateExpressionModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					graphEdit.add_child(loadedNode)
				"hkbExpressionDataArray":
					print("hkbExpressionDataArray loaded.")
					var loadedNode = globalVariable.hkbExpressionDataArray.instantiate()
					base_node_values(loadedNode, object)
					#loadedNode.expressionArray							= node.expressionArray
					graphEdit.add_child(loadedNode)
				"hkbPoseMatchingGenerator":
					print("hkbPoseMatchingGenerator loaded.")
					var loadedNode = globalVariable.hkbPoseMatchingGenerator.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					#loadedNode.blendParameter = node.blendParameter
					#loadedNode.blendSpeed = node.blendSpeed
					#loadedNode.minSpeedToSwitch = node.minSpeedToSwitch
					#loadedNode.startPlayingEventId = node.startPlayingEventId
					#loadedNode.startMatchingEventId = node.startMatchingEventId
					#loadedNode.rootBoneIndex = node.rootBoneIndex
					#loadedNode.otherBoneIndex = node.otherBoneIndex
					#loadedNode.anotherBoneIndex = node.anotherBoneIndex
					#loadedNode.pelvisIndex = node.pelvisIndex
					graphEdit.add_child(loadedNode)
				"hkbBlenderGenerator":
					print("hkbBlenderGenerator loaded.")
					var loadedNode = globalVariable.hkbBlenderGenerator.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					#loadedNode.blendParameter							= node.blendParameter
					#loadedNode.maxCyclicBlendParameter					= node.maxCyclicBlendParameter
					#loadedNode.indexOfSyncMasterChild					= node.indexOfSyncMasterChild
					#loadedNode.flagsIndex								= node.flagsIndex
					graphEdit.add_child(loadedNode)
				"hkbBlenderGeneratorChild":
					print("hkbBlenderGeneratorChild loaded.")
					var loadedNode = globalVariable.hkbBlenderGeneratorChild.instantiate()
					base_node_values(loadedNode, object)
					#loadedNode.weight				 = node.weight
					#loadedNode.worldFromModelWeight	 = node.worldFromModelWeight
					graphEdit.add_child(loadedNode)
				"hkbClipGenerator":
					print("hkbClipGenerator loaded.")
					var loadedNode = globalVariable.hkbClipGenerator.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					#loadedNode.animationName				 = node.animationName
					#loadedNode.cropStartAmountLocalTime		 = node.cropStartAmountLocalTime
					#loadedNode.cropEndAmountLocalTime		 = node.cropEndAmountLocalTime
					#loadedNode.startTime					 = node.startTime
					#loadedNode.playbackSpeed				 = node.playbackSpeed
					#loadedNode.enforcedDuration				 = node.enforcedDuration
					#loadedNode.userControlledTimeFraction	 = node.userControlledTimeFraction
					#loadedNode.mode							 = node.mode
					#loadedNode.flagsIndex					 = node.flagsIndex
					graphEdit.add_child(loadedNode)
				"hkbClipTriggerArray":
					print("hkbClipTriggerArray loaded.")
					var loadedNode = globalVariable.hkbClipTriggerArray.instantiate()
					base_node_values(loadedNode, object)
					#loadedNode.triggersArray = node.triggersArray
					#graphEdit.add_child(loadedNode)
				#27:
					#print("hkbBlendingTransitionEffect loaded.")
				"hkbEventDrivenModifier":
					print("hkbEventDrivenModifier loaded.")
					var loadedNode = globalVariable.hkbEventDrivenModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					#loadedNode.activateEventId 	 = node.activateEventId
					#loadedNode.deactivateEventId = node.deactivateEventId
					#loadedNode.activeByDefault	 = node.activeByDefault
					graphEdit.add_child(loadedNode)
				"hkbPoweredRagdollControlsModifier":
					print("hkbPoweredRagdollControlsModifier loaded.")
					var loadedNode = globalVariable.hkbPoweredRagdollControlsModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					#loadedNode.maxForce						= node.maxForce
					#loadedNode.tau							= node.tau
					#loadedNode.damping 						= node.damping
					#loadedNode.proportionalRecoveryVelocity = node.proportionalRecoveryVelocity
					#loadedNode.constantRecoveryVelocity		= node.constantRecoveryVelocity
					#loadedNode.poseMatchingBone0 			= node.poseMatchingBone0
					#loadedNode.poseMatchingBone1 			= node.poseMatchingBone1
					#loadedNode.poseMatchingBone2 			= node.poseMatchingBone2
					#loadedNode.animationBlendFraction		= node.animationBlendFraction
					graphEdit.add_child(loadedNode)
				"hkbTimerModifier":
					print("hkbTimerModifier loaded.")
					var loadedNode = globalVariable.hkbTimerModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					#loadedNode.alarmTimeSeconds		= node.alarmTimeSeconds
					#loadedNode.eventId 				= node.eventId
					#loadedNode.payload				= node.payload
					graphEdit.add_child(loadedNode)
				31:
					print("BSLookAtModifier loaded.")
				"BSGetTimeStepModifier":
					print("BSGetTimeStepModifier loaded.")
					var loadedNode = globalVariable.BSGetTimeStepModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					#loadedNode.timeStep				= node.timeStep
					graphEdit.add_child(loadedNode)
				"hkbTwistModifier":
					print("hkbTwistModifier loaded.")
					var loadedNode = globalVariable.hkbTwistModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					#loadedNode.axisOfRotation			 = node.axisOfRotation
					#loadedNode.twistAngle				 = node.twistAngle
					#loadedNode.startBoneIndex			 = node.startBoneIndex
					#loadedNode.endBoneIndex				 = node.endBoneIndex
					#loadedNode.setAngleMethod			 = node.setAngleMethod
					#loadedNode.rotationAxisCoordinates	 = node.rotationAxisCoordinates
					#loadedNode.isAdditive				 = node.isAdditive
					graphEdit.add_child(loadedNode)
				"BSInterpValueModifier":
					print("BSInterpValueModifier loaded.")
					var loadedNode = globalVariable.BSInterpValueModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					loadedNode.source					 = object.children[4].content
					loadedNode.target					 = object.children[5].content
					loadedNode.result					 = object.children[6].content
					loadedNode.gain						 = object.children[7].content
					graphEdit.add_child(loadedNode)
				"hkbEventsFromRangeModifier":
					print("hkbEventsFromRangeModifier loaded.")
					var loadedNode = globalVariable.hkbEventsFromRangeModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					loadedNode.inputValue				 = object.children[4].content
					loadedNode.lowerBound				 = object.children[5].content
					graphEdit.add_child(loadedNode)
				"hkbEventRangeDataArray":
					print("hkbEventRangeDataArray loaded.")
					var loadedNode = globalVariable.hkbEventRangeDataArray.instantiate()
					base_node_values(loadedNode, object)
					#loadedNode.rangeArray				 = node.rangeArray
					graphEdit.add_child(loadedNode)
				"BSBehaviorGraphSwapGenerator":
					print("BSBehaviorGraphSwapGenerator loaded.")
					var loadedNode = globalVariable.BSBehaviorGraphSwapGenerator.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					graphEdit.add_child(loadedNode)
				"BSCyclicBlendTransitionGenerator":
					print("BSCyclicBlendTransitionGenerator loaded.")
					var loadedNode = globalVariable.BSCyclicBlendTransitionGenerator.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					#loadedNode.EventToFreezeBlendValueID	 	= node.EventToFreezeBlendValueID
					#loadedNode.EventToFreezeBlendValuePayload	= node.EventToFreezeBlendValuePayload
					#loadedNode.EventToCrossBlendID				 = node.EventToCrossBlendID
					#loadedNode.EventToCrossBlendPayload			 = node.EventToCrossBlendPayload
					#loadedNode.TransitionOutEventID				 = node.TransitionOutEventID
					#loadedNode.TransitionOutEventPayload		 = node.TransitionOutEventPayload
					#loadedNode.TransitionInEventID				 = node.TransitionInEventID
					#loadedNode.TransitionInEventPayload			 = node.TransitionInEventPayload
					#loadedNode.fTransitionDuration				 = node.fTransitionDuration
					graphEdit.add_child(loadedNode)
				"BGSGamebryoSequenceGenerator":
					print("BGSGamebryoSequenceGenerator loaded.")
					var loadedNode = globalVariable.BGSGamebryoSequenceGenerator.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData 			= int(object.children[1].content)
					loadedNode.nodeName 			= object.children[2].content
					loadedNode.pSequence			= object.children[3].content
					#loadedNode.eBlendModeFunction	= node.eBlendModeFunction
					#loadedNode.fPercent				= node.fPercent
					#loadedNode.eUseTimePercentage	= node.eUseTimePercentage
					#loadedNode.fTimePercent			= node.fTimePercent
					graphEdit.add_child(loadedNode)
				"hkbBehaviorReferenceGenerator":
					print("hkbBehaviorReferenceGenerator loaded.")
					var loadedNode = globalVariable.hkbBehaviorReferenceGenerator.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData 				= int(object.children[1].content)
					loadedNode.nodeName 				= object.children[2].content
					loadedNode.behaviorName				= object.children[3].content
					graphEdit.add_child(loadedNode)
				"BSAssignVariablesModifier":
					print("BSAssignVariablesModifier loaded.")
					var loadedNode = globalVariable.BSAssignVariablesModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					#loadedNode.floatVariable		= node.floatVariable
					#loadedNode.floatValue			= node.floatValue
					#loadedNode.intVariable			= node.intVariable
					#loadedNode.intValue				= node.intValue
					graphEdit.add_child(loadedNode)
				"DynamicAnimationTaggingGenerator":
					print("DynamicAnimationTaggingGenerator loaded.")
					var loadedNode = globalVariable.DynamicAnimationTaggingGenerator.instantiate()
					base_node_values(loadedNode, object)
					#loadedNode.nodeName				= node.nodeName
					#loadedNode.userData				= node.userData
					graphEdit.add_child(loadedNode)
				"BSTimerModifier":
					print("BSTimerModifier loaded.")
					var loadedNode = globalVariable.BSTimerModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "false":
						loadedNode.enable = false
					#loadedNode.alarmTimeSeconds		= node.alarmTimeSeconds
					#loadedNode.resetAlarm			= node.resetAlarm
					#loadedNode.eventId				= node.eventId
					#loadedNode.payload				= node.payload
					graphEdit.add_child(loadedNode)
				"hkbGeneratorTransitionEffect":
					print("hkbGeneratorTransitionEffect loaded.")
					var loadedNode = globalVariable.hkbGeneratorTransitionEffect.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					#loadedNode.selfTransitionMode		= node.selfTransitionMode
					#loadedNode.eventMode				= node.eventMode
					#loadedNode.blendInDuration			= node.blendInDuration
					#loadedNode.blendOutDuration			= node.blendOutDuration
					#loadedNode.syncToGeneratorStartTime	= node.syncToGeneratorStartTime
					graphEdit.add_child(loadedNode)
				"hkbReferencePoseGenerator":
					print("hkbReferencePoseGenerator loaded.")
					var loadedNode = globalVariable.hkbReferencePoseGenerator.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					graphEdit.add_child(loadedNode)

func base_node_values(loadedNode, object):
	loadedNode.title += ' - ' + str(object.attributes.name)
	loadedNode.nodeID = int(object.attributes.name.replace("#",""))
