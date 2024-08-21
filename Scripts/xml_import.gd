extends Node

func _load_XML(path, graphEdit):
	var parsedFile = XML.parse_file(path)
	var rootNode = parsedFile.root
	var connections = []
	var unhandledNodes = []
	var transitionValues = []
	var payloadValues = []
	print("Root Node: ", rootNode.attributes)
	transitionValues = import_transitions(rootNode.children[0].children)
	print(transitionValues)
	payloadValues = import_payload(rootNode.children[0].children)
	print(payloadValues)
	
	import_values(rootNode)
	graphEdit.get_parent()._instantiate_global_values()
	print(globalVariable.globalEventList)
	for object in rootNode.children[0].children:
		if true:
		#if object.attributes.class != "hkbBehaviorGraphData" and object.attributes.class != "hkbVariableValueSet" and object.attributes.class != "hkbBehaviorGraphStringData":
			print(object.attributes.name, " - ", object.attributes.class)
			unhandledNodes.append(_object_processing(object, graphEdit, connections, transitionValues, payloadValues))
			print("[")
			var child_count = 0
			for parameter in object.children:
				print("	", " #", child_count," - " , parameter.attributes.name, " = ", parameter.content)
				child_count += 1
				if parameter.attributes.name == "transitions":
					var transition_count = 1
					for transition in parameter.children:
						print("			Transition #", transition_count)
						for value in transition.children:
							#print("		", transition.content)
							child_count += 1
							print("				", value.attributes.name, " = ", value.content)
				if parameter.attributes.has("numelements"):
					for subparameter in parameter.children:
						if subparameter.content == "":
							for subparameter2 in subparameter.children:
								print("		", subparameter2.attributes.name, " = ", subparameter2.content)
						else:
							print("		",subparameter.content)
				#if parameter.attributes.name == "eventToSendWhenStateOrTransitionChanges":
					#print("		", parameter.children[0].children[0].attributes.name, " = ", parameter.children[0].children[0].content)
					#print("		", parameter.children[0].children[1].attributes.name, " = ", parameter.children[0].children[1].content)
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
	print("Connections: ", connections)
	for connection in connections:
		for from_node in graphEdit.get_children():
			if from_node.get("nodeID") == connection[1]:
				for to_node in graphEdit.get_children():
					if to_node.get("nodeID") == connection[2]:
						graphEdit.connect_node(str(from_node.name), connection[0], str(to_node.name), 0)
	return unhandledNodes

func _object_processing(object, graphEdit, connections, transitionValues, payloadValues):
			match object.attributes.class:
				"hkRootLevelContainer":
					print("hkRootLevelContainer loaded.")
					var loadedNode = globalVariable.hkRootLevelContainer.instantiate()
					base_node_values(loadedNode, object)
					#if object.children[0].children[0].children[2].content != "null":
						#connections.append(0, [int(object.attributes.name.replace("#","")), int(object.children[0].children[0].children[2].content.replace("#",""))])
					if object.children[0].children[0].children[2].content != "null":
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].children[0].children[2].content.replace("#",""))])
					graphEdit.add_child(loadedNode)
				"hkbBehaviorGraph":
					print("hkbBehaviorGraph loaded.")
					var loadedNode = globalVariable.hkbBehaviorGraph.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.nodeName = object.children[2].content
					if object.children[4].content != "null":
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[4].content.replace("#",""))])
					graphEdit.add_child(loadedNode)
				"hkbBehaviorGraphData":
					print("hkbBehaviorGraphData loaded.")
				"hkbVariableValueSet":
					print("hkbVariableValueSet loaded.")
				"hkbBehaviorGraphStringData":
					print("hkbBehaviorGraphStringData loaded.")
				"hkbStateMachine":
					print("hkbStateMachine loaded.")
					var loadedNode = globalVariable.hkbStateMachine.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.eventId = int(object.children[3].children[0].children[0].content)
					if object.children[3].children[0].children[1].content != "null":
						for payload in payloadValues:
							if payload[0] == object.children[3].children[0].children[1].content:
								loadedNode.payload = payload[1]
					else:
						loadedNode.payload = -1
					loadedNode.startStateId = int(object.children[5].content)
					loadedNode.randomTransitionEventId = int(object.children[7].content)
					loadedNode.transitionToNextHigherStateEventId = int(object.children[8].content)
					loadedNode.transitionToNextLowerStateEventId = int(object.children[9].content)
					loadedNode.syncVariableIndex = int(object.children[10].content)
					loadedNode.wrapAroundStateId = string_to_bool(object.children[11].content)
					loadedNode.startStateMode = object.children[13].content
					loadedNode.selfTransitionMode = object.children[14].content
					if object.children[15].content != "null": # states
						for state in object.children[15].content.split("#"):
							if state:
								connections.append([1, int(object.attributes.name.replace("#","")), int(state)])
					if object.children[16].content != "null": # wildcardTransitions
						connections.append([2, int(object.attributes.name.replace("#","")), int(object.children[16].content.replace("#",""))])
					graphEdit.add_child(loadedNode)
				"hkbStateMachineStateInfo":
					print("hkbStateMachineStateInfo loaded.")
					var loadedNode = globalVariable.hkbStateMachineStateInfo.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					if object.children[2].content != "null": # enterNotifyEvents
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[2].content.replace("#",""))])
					if object.children[3].content != "null": # exitNotifyEvents
						connections.append([2, int(object.attributes.name.replace("#","")), int(object.children[3].content.replace("#",""))])
					if object.children[4].content != "null": # transitions
						connections.append([3, int(object.attributes.name.replace("#","")), int(object.children[4].content.replace("#",""))])
					if object.children[5].content != "null": # generator
						for generator in object.children[5].content.split("#"):
							if generator:
								connections.append([4, int(object.attributes.name.replace("#","")), int(generator)])
					loadedNode.nodeName = object.children[6].content
					loadedNode.stateId = int(object.children[7].content)
					loadedNode.probability = object.children[8].content
					loadedNode.enable = string_to_bool(object.children[9].content)
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
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content != "null": # modifier
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[3].content.replace("#",""))])
					if object.children[4].content != "null": # generator
						connections.append([2, int(object.attributes.name.replace("#","")), int(object.children[4].content.replace("#",""))])
					graphEdit.add_child(loadedNode)
				"hkbModifierList":
					print("hkbModifierList loaded.")
					var loadedNode = globalVariable.hkbModifierList.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					if object.children[4].content != "null": # modifiers
						for modifier in object.children[4].content.split("#"):
							if modifier:
								connections.append([1, int(object.attributes.name.replace("#","")), int(modifier)])
					graphEdit.add_child(loadedNode)
				"hkbGetUpModifier":
					print("hkbGetUpModifier loaded.")
					var loadedNode = globalVariable.hkbGetUpModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
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
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					if object.children[5].content != "null": # keyframedBonesList
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[5].content.replace("#",""))])
					graphEdit.add_child(loadedNode)
				"hkbBoneIndexArray":
					print("hkbBoneIndexArray loaded.")
					var loadedNode = globalVariable.hkbBoneIndexArray.instantiate()
					base_node_values(loadedNode, object)
					if object.children[1].content != "null": # boneIndices
						for bone in object.children[1].content.replace("\r\n"," ").split(" "):
							if bone:
								loadedNode.boneIndices.append(int(bone))
					graphEdit.add_child(loadedNode)
				"hkbBoneWeightArray":
					print("hkbBoneWeightArray loaded.")
					var loadedNode = globalVariable.hkbBoneWeightArray.instantiate()
					base_node_values(loadedNode, object)
					if object.children[1].content != "null": # boneWeights
						for bone in object.children[1].content.replace("\r\n"," ").split(" "):
							if bone:
								loadedNode.boneWeights.append(bone)
					graphEdit.add_child(loadedNode)
				"hkbRigidBodyRagdollControlsModifier":
					print("hkbRigidBodyRagdollControlsModifier loaded.")
					var loadedNode = globalVariable.hkbRigidBodyRagdollControlsModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					loadedNode.hierarchyGain = object.children[4].children[0].children[0].children[0].children[0].content
					loadedNode.velocityDamping = object.children[4].children[0].children[0].children[0].children[1].content
					loadedNode.accelerationGain = object.children[4].children[0].children[0].children[0].children[2].content
					loadedNode.velocityGain = object.children[4].children[0].children[0].children[0].children[3].content
					loadedNode.positionGain = object.children[4].children[0].children[0].children[0].children[4].content
					loadedNode.positionMaxLinearVelocity = object.children[4].children[0].children[0].children[0].children[5].content
					loadedNode.positionMaxAngularVelocity = object.children[4].children[0].children[0].children[0].children[6].content
					loadedNode.snapGain = object.children[4].children[0].children[0].children[0].children[7].content
					loadedNode.snapMaxLinearVelocity = object.children[4].children[0].children[0].children[0].children[8].content
					loadedNode.snapMaxAngularVelocity = object.children[4].children[0].children[0].children[0].children[9].content
					loadedNode.snapMaxLinearDistance = object.children[4].children[0].children[0].children[0].children[10].content
					loadedNode.snapMaxAngularDistance = object.children[4].children[0].children[0].children[0].children[11].content
					loadedNode.durationToBlend = object.children[4].children[0].children[1].content
					if object.children[5].content != "null": # Bones
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[5].content.replace("#",""))])
					loadedNode.animationBlendFraction = object.children[6].content
					graphEdit.add_child(loadedNode)
				"BSIsActiveModifier":
					print("BSIsActiveModifier loaded.")
					var loadedNode = globalVariable.BSIsActiveModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					loadedNode.bIsActiveArray	= [
						string_to_bool(object.children[4].content), 
						string_to_bool(object.children[6].content), 
						string_to_bool(object.children[8].content), 
						string_to_bool(object.children[10].content), 
						string_to_bool(object.children[12].content), 
						string_to_bool(object.children[5].content), 
						string_to_bool(object.children[7].content), 
						string_to_bool(object.children[9].content), 
						string_to_bool(object.children[11].content), 
						string_to_bool(object.children[13].content)]
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
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content != "null": # generators
						for generator in object.children[3].content.split("#"):
							if generator:
								connections.append([1, int(object.attributes.name.replace("#","")), int(generator)])
					loadedNode.selectedGeneratorIndex = int(object.children[4].content)
					if object.children[5].content != "null": # indexSelector
						connections.append([2, int(object.attributes.name.replace("#","")), int(object.children[5].content.replace("#",""))])
					loadedNode.selectedIndexCanChangeAfterActivate 		= string_to_bool(object.children[6].content)
					# TODO: Take into account the transition list.
					#if object.children[7].content != "null": # generatorChangedTransitionEffect
						#loadedNode.generatorChangedTransitionEffect 		= int(object.children[7].content.replace("#",""))
					graphEdit.add_child(loadedNode)
				"BSModifyOnceModifier":
					print("BSModifyOnceModifier loaded.")
					var loadedNode = globalVariable.BSModifyOnceModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					if object.children[4].content != "null": # pOnActivateModifier
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[4].content.replace("#",""))])
					if object.children[5].content != "null": # pOnDeactivateModifier
						connections.append([2, int(object.attributes.name.replace("#","")), int(object.children[5].content.replace("#",""))])
					graphEdit.add_child(loadedNode)
				"hkbEvaluateExpressionModifier":
					print("hkbEvaluateExpressionModifier loaded.")
					var loadedNode = globalVariable.hkbEvaluateExpressionModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					if object.children[4].content != "null": # expressions
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[4].content.replace("#",""))])
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
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.blendParameter = object.children[4].content
					loadedNode.blendSpeed = object.children[12].content
					loadedNode.minSpeedToSwitch = object.children[13].content
					loadedNode.startPlayingEventId = int(object.children[16].content)
					loadedNode.startMatchingEventId = int(object.children[17].content)
					loadedNode.rootBoneIndex = int(object.children[18].content)
					loadedNode.otherBoneIndex = int(object.children[19].content)
					loadedNode.anotherBoneIndex = int(object.children[20].content)
					loadedNode.pelvisIndex = int(object.children[21].content)
					graphEdit.add_child(loadedNode)
				"hkbBlenderGenerator":
					print("hkbBlenderGenerator loaded.")
					var loadedNode = globalVariable.hkbBlenderGenerator.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData									= int(object.children[1].content)
					loadedNode.nodeName									= object.children[2].content
					loadedNode.blendParameter							= object.children[4].content
					loadedNode.maxCyclicBlendParameter					= object.children[5].content
					loadedNode.indexOfSyncMasterChild					= int(object.children[6].content)
					loadedNode.flagsIndex								= int(object.children[8].content)
					if object.children[10].content != "null": # children
						for child in object.children[10].content.split("#"):
							if child:
								connections.append([1, int(object.attributes.name.replace("#","")), int(child)])
					graphEdit.add_child(loadedNode)
				"hkbBlenderGeneratorChild":
					print("hkbBlenderGeneratorChild loaded.")
					var loadedNode = globalVariable.hkbBlenderGeneratorChild.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					if object.children[1].content != "null": # generator
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[1].content.replace("#",""))])
					if object.children[2].content != "null": # boneWeights
						connections.append([2, int(object.attributes.name.replace("#","")), int(object.children[2].content.replace("#",""))])
					loadedNode.weight				 = object.children[3].content
					loadedNode.worldFromModelWeight	 = object.children[4].content
					graphEdit.add_child(loadedNode)
				"hkbClipGenerator":
					print("hkbClipGenerator loaded.")
					var loadedNode = globalVariable.hkbClipGenerator.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.animationName				 = object.children[4].content
					if object.children[5].content != "null": # triggers
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[5].content.replace("#",""))])
					loadedNode.cropStartAmountLocalTime		 = object.children[7].content
					loadedNode.cropEndAmountLocalTime		 = object.children[8].content
					loadedNode.startTime					 = object.children[9].content
					loadedNode.playbackSpeed				 = object.children[10].content
					loadedNode.enforcedDuration				 = object.children[11].content
					loadedNode.userControlledTimeFraction	 = object.children[12].content
					loadedNode.mode							 = object.children[14].content
					if object.children[14].content == "MODE_LOOPING":
						loadedNode.mode = 1
					elif object.children[14].content == "MODE_USER_CONTROLLED":
						loadedNode.mode = 2
					else:
						loadedNode.mode = 0
					loadedNode.flagsIndex					 = int(object.children[15].content)
					graphEdit.add_child(loadedNode)
				"hkbClipTriggerArray":
					print("hkbClipTriggerArray loaded.")
					var loadedNode = globalVariable.hkbClipTriggerArray.instantiate()
					base_node_values(loadedNode, object)
					#loadedNode.triggersArray = node.triggersArray
					graphEdit.add_child(loadedNode)
				"hkbBlendingTransitionEffect":
					print("hkbBlendingTransitionEffect loaded.")
				"hkbEventDrivenModifier":
					print("hkbEventDrivenModifier loaded.")
					var loadedNode = globalVariable.hkbEventDrivenModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					if object.children[4].content != "null": # modifier
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[4].content.replace("#",""))])
					loadedNode.activateEventId 	 = int(object.children[5].content)
					loadedNode.deactivateEventId = int(object.children[6].content)
					loadedNode.activeByDefault	 = string_to_bool(object.children[7].content)
					graphEdit.add_child(loadedNode)
				"hkbPoweredRagdollControlsModifier":
					print("hkbPoweredRagdollControlsModifier loaded.")
					var loadedNode = globalVariable.hkbPoweredRagdollControlsModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData						= int(object.children[1].content)
					loadedNode.nodeName						= object.children[2].content
					loadedNode.enable						= string_to_bool(object.children[3].content)
					loadedNode.maxForce						= object.children[4].children[0].children[0].content
					loadedNode.tau							= object.children[4].children[0].children[1].content
					loadedNode.damping 						= object.children[4].children[0].children[2].content
					loadedNode.proportionalRecoveryVelocity = object.children[4].children[0].children[3].content
					loadedNode.constantRecoveryVelocity		= object.children[4].children[0].children[4].content
					if object.children[5].content != "null": # bones
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[5].content.replace("#",""))])
					loadedNode.poseMatchingBone0 			= int(object.children[6].children[0].children[0].content)
					loadedNode.poseMatchingBone1 			= int(object.children[6].children[0].children[1].content)
					loadedNode.poseMatchingBone2 			= int(object.children[6].children[0].children[2].content)
					if object.children[6].children[0].children[3].content == "WORLD_FROM_MODEL_MODE_RAGDOLL":
						loadedNode.mode = 2
					elif object.children[6].children[0].children[3].content == "WORLD_FROM_MODEL_MODE_NONE":
						loadedNode.mode = 1
					else:
						loadedNode.mode = 0
					if object.children[7].content != "null": # boneWeights
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[7].content.replace("#",""))])
					loadedNode.animationBlendFraction		= object.children[8].content
					graphEdit.add_child(loadedNode)
				"hkbTimerModifier":
					print("hkbTimerModifier loaded.")
					var loadedNode = globalVariable.hkbTimerModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					loadedNode.alarmTimeSeconds		= object.children[4].content
					#loadedNode.eventId 				= node.eventId
					#loadedNode.payload					= node.payload
					graphEdit.add_child(loadedNode)
				"BSLookAtModifier":
					print("BSLookAtModifier loaded.")
				"BSGetTimeStepModifier":
					print("BSGetTimeStepModifier loaded.")
					var loadedNode = globalVariable.BSGetTimeStepModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					#loadedNode.timeStep				= node.timeStep
					graphEdit.add_child(loadedNode)
				"hkbTwistModifier":
					print("hkbTwistModifier loaded.")
					var loadedNode = globalVariable.hkbTwistModifier.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
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
					loadedNode.enable = string_to_bool(object.children[3].content)
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
					loadedNode.enable = string_to_bool(object.children[3].content)
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
					loadedNode.enable = string_to_bool(object.children[3].content)
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
					loadedNode.enable = string_to_bool(object.children[3].content)
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
				"hkbStringEventPayload":
					print("hkbStringEventPayload loaded.")
				"hkbReferencePoseGenerator":
					print("hkbReferencePoseGenerator loaded.")
					var loadedNode = globalVariable.hkbReferencePoseGenerator.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					graphEdit.add_child(loadedNode)
				_:
					return object.attributes.name + " - " + object.attributes.class

func base_node_values(loadedNode, object):
	loadedNode.title += ' - ' + str(object.attributes.name)
	loadedNode.nodeID = int(object.attributes.name.replace("#",""))

func import_transitions(objectList):
	var transitionIndex = 0
	var transitionConversion = []
	globalVariable.globalTransitionList = []
	for object in objectList:
		if object.attributes.class == "hkbBlendingTransitionEffect":
			transitionIndex += 1
			var transitionData = {
				"transitionID": transitionIndex,
				"transitionName": object.children[2].content,
				"transitionVariableBindingSet": 0,
				"transitionSelfTransitionMode": 0,
				"transitionEventMode": 0,
				"transitionDuration": object.children[5].content,
				"transitionToGeneratorStartTimeFraction": object.children[6].content,
				"transitionFlags": 0,
				"transitionEndMode": 0,
				"transitionBlendCurve": int(object.children[9].content)
			}
			if object.children[0].content != "null":
				transitionData.transitionVariableBindingSet = int(object.children[0].content.replace("#",""))
			if object.children[3].content == "SELF_TRANSITION_MODE_CONTINUE_IF_CYCLIC_BLEND_IF_ACYCLIC":
				transitionData.transitionSelfTransitionMode = 0
			elif object.children[3].content == "SELF_TRANSITION_MODE_CONTINUE":
				transitionData.transitionSelfTransitionMode = 1
			elif object.children[3].content == "SELF_TRANSITION_MODE_RESET":
				transitionData.transitionSelfTransitionMode = 2
			elif object.children[3].content == "SELF_TRANSITION_MODE_BLEND":
				transitionData.transitionSelfTransitionMode = 3
			if object.children[4].content == "EVENT_MODE_DEFAULT":
				transitionData.transitionEndMode = 0
			elif object.children[4].content == "EVENT_MODE_PROCESS_ALL":
				transitionData.transitionEndMode = 1
			elif object.children[4].content == "EVENT_MODE_IGNORE_FROM_GENERATOR":
				transitionData.transitionEndMode = 2
			elif object.children[4].content == "EVENT_MODE_IGNORE_TO_GENERATOR":
				transitionData.transitionEndMode = 3
			if object.children[7].content == "FLAG_NONE":
				transitionData.transitionFlags = 0
			elif object.children[7].content == "FLAG_IGNORE_FROM_WORLD_FROM_MODEL":
				transitionData.transitionFlags = 1
			elif object.children[7].content == "FLAG_SYNC":
				transitionData.transitionFlags = 2
			elif object.children[7].content == "FLAG_IGNORE_TO_WORLD_FROM_MODEL":
				transitionData.transitionFlags = 3
			elif object.children[7].content == "FLAG_IGNORE_TO_WORLD_FROM_MODEL_ROTATION":
				transitionData.transitionFlags = 4
			if object.children[8].content == "END_MODE_NONE":
				transitionData.transitionEndMode = 0
			else:
				transitionData.transitionEndMode = 1
			transitionConversion.append([object.attributes.name, transitionIndex])
			globalVariable.globalTransitionList.append(transitionData)
	return transitionConversion

func import_payload(objectList):
	var payloadIndex = 0
	var payloadConversion = []
	globalVariable.globalPayloadList = []
	for object in objectList:
		if object.attributes.class == "hkbStringEventPayload":
			payloadIndex += 1
			var payloadData = {
				"payloadID": payloadIndex,
				"payloadName": object.children[0].content,
			}
			globalVariable.globalPayloadList.append(payloadData)
			payloadConversion.append([object.attributes.name, payloadIndex])
	return payloadConversion

func import_values(rootNode):
	var hkbBehaviorGraphData = null
	var hkbVariableValueSet = null
	var hkbBehaviorGraphStringData = null
	for node in rootNode.children[0].children:
		#print("Searching for Graph Data: ", node.attributes.name, " - ", node.attributes.class)
		if node.attributes.class == "hkbBehaviorGraphData":
			#print("Found hkbBehaviorGraphData: ", node.attributes.name)
			hkbBehaviorGraphData = node
		elif node.attributes.class == "hkbVariableValueSet":
			#print("Found hkbVariableValueSet: ", node.attributes.name)
			hkbVariableValueSet = node
		elif node.attributes.class == "hkbBehaviorGraphStringData":
			#print("Found hkbBehaviorGraphStringData: ", node.attributes.name)
			hkbBehaviorGraphStringData = node
	if hkbBehaviorGraphData == null || hkbVariableValueSet == null || hkbBehaviorGraphStringData == null:
		print("Failed to acquire graph data.")
		return
	#return
	globalVariable.globalEventList = []
	#print(hkbBehaviorGraphData.children[3].attributes.numelements)
	#if hkbBehaviorGraphData.children[3].attributes.numelements
	print("GraphData: ", hkbBehaviorGraphData.attributes.class)
	for child in hkbBehaviorGraphData.children:
		print("GraphData Attributes", child.attributes)
	if hkbBehaviorGraphData.children[3].attributes.has("numelements"):
		print("Event Number: ",hkbBehaviorGraphData.children[3].attributes.numelements)
		for eventNum in range(int(hkbBehaviorGraphData.children[3].attributes.numelements)):
			var eventData = {
					"eventID": eventNum,
					"eventName": hkbBehaviorGraphStringData.children[0].children[eventNum].content,
					"eventFlags": 0,
				}
			if hkbBehaviorGraphData.children[3].children[eventNum].children[0].content == "FLAG_SYNC_POINT":
				eventData.eventFlags = 1
			globalVariable.globalEventList.append(eventData)
			#print(hkbBehaviorGraphStringData.children[0].children[eventNum].content + " - " + hkbBehaviorGraphData.children[3].children[eventNum].children[0].content)
	globalVariable.globalVariableList = []
	print(hkbBehaviorGraphData.children[1].content)
	if hkbBehaviorGraphData.children[1].attributes.has("numelements"):
		print("Variable Number: ",hkbBehaviorGraphData.children[1].attributes.numelements)
		for variableNum in range(int(hkbBehaviorGraphData.children[1].attributes.numelements)):
			var variableData = {
					"variableID": variableNum,
					"variableName": hkbBehaviorGraphStringData.children[2].children[variableNum].content,
					"variableType": 0,
					"variableValue": hkbVariableValueSet.children[0].children[variableNum].children[0].content,
					"variableMinValue": "0",
					"variableMaxValue": "0",
					"variableQuadValues": "(0.0 0.0 0.0 0.0)"
				}
			print(hkbBehaviorGraphData.children[1].children[variableNum].children[1].content)
			#if hkbBehaviorGraphData.children[1].children[variableNum].children[0].content == "FLAG_SYNC_POINT":
				#variableData.eventFlags = 1
			if hkbBehaviorGraphData.children[1].children[variableNum].children[1].content == "VARIABLE_TYPE_BOOL":
				variableData.variableType = 0
			elif hkbBehaviorGraphData.children[1].children[variableNum].children[1].content == "VARIABLE_TYPE_INT8":
				variableData.variableType = 1
			elif hkbBehaviorGraphData.children[1].children[variableNum].children[1].content == "VARIABLE_TYPE_INT16":
				variableData.variableType = 2
			elif hkbBehaviorGraphData.children[1].children[variableNum].children[1].content == "VARIABLE_TYPE_INT32":
				variableData.variableType = 3
			elif hkbBehaviorGraphData.children[1].children[variableNum].children[1].content == "VARIABLE_TYPE_REAL":
				variableData.variableType = 4
			elif hkbBehaviorGraphData.children[1].children[variableNum].children[1].content == "VARIABLE_TYPE_POINTER":
				variableData.variableType = 5
			elif hkbBehaviorGraphData.children[1].children[variableNum].children[1].content == "VARIABLE_TYPE_VECTOR4":
				variableData.variableType = 6
			elif hkbBehaviorGraphData.children[1].children[variableNum].children[1].content == "VARIABLE_TYPE_QUATERNION":
				variableData.variableType = 7
			print(variableData.variableID, " - ", variableData.variableName)
			globalVariable.globalVariableList.append(variableData)
	
	print(hkbBehaviorGraphData.attributes.name, " - ", hkbBehaviorGraphData.attributes.class)
	#print(hkbBehaviorGraphData.children[3].attributes.name, " = ", hkbBehaviorGraphData.children[3].attributes.numelements)
	#for eventInfo in hkbBehaviorGraphData.children[3].children:
		#print(eventInfo.children[0].content)
	print(hkbVariableValueSet.attributes.name, " - ", hkbVariableValueSet.attributes.class)
	print(hkbBehaviorGraphStringData.attributes.name, " - ", hkbBehaviorGraphStringData.attributes.class)
	#print(hkbBehaviorGraphStringData.children[0].attributes.name, " = ", hkbBehaviorGraphStringData.children[0].attributes.numelements)
	#for event in hkbBehaviorGraphStringData.children[0].children:
		#print(event.content)

func string_to_bool(string):
	if string == "true":
		return true
	else:
		return false
