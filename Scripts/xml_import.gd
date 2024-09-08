extends Node

func _load_XML(path, graphEdit, variableBoundPadding):
	var parsedFile = XML.parse_file(path)
	var rootNode = parsedFile.root
	var connections = []
	var unhandledNodes = []
	var transitionValues = []
	var payloadValues = []
	#print("Root Node: ", rootNode.attributes)
	transitionValues = import_transitions(rootNode.children[0].children)
	#print(transitionValues)
	payloadValues = import_payload(rootNode.children[0].children)
	#print(payloadValues)
	
	import_values(rootNode, variableBoundPadding)
	graphEdit.get_parent()._instantiate_global_values()
	#print(globalVariable.globalEventList)
	for object in rootNode.children[0].children:
		#if true:
		if object.attributes.class != "hkbBehaviorGraphData" and object.attributes.class != "hkbVariableValueSet" and object.attributes.class != "hkbBehaviorGraphStringData":
			#print(object.attributes.name, " - ", object.attributes.class)
			unhandledNodes.append(_object_processing(object, graphEdit, connections, transitionValues, payloadValues))
			#print("[")
			var child_count = 0
			
			
			
			#for parameter in object.children:
				#print("	", " #", child_count," - " , parameter.attributes.name, " = ", parameter.content)
				#child_count += 1
				#if parameter.attributes.name == "transitions":
					#var transition_count = 1
					#for transition in parameter.children:
						#print("			Transition #", transition_count)
						#transition_count += 1
						#for value in transition.children:
							##print("		", transition.content)
							#child_count += 1
							#print("				", value.attributes.name, " = ", value.content)
				#if parameter.attributes.has("numelements"):
					#for subparameter in parameter.children:
						#if subparameter.content == "":
							#for subparameter2 in subparameter.children:
								#print("		", subparameter2.attributes.name, " = ", subparameter2.content)
						#else:
							#print("		",subparameter.content)
							
							
							
							
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




			#print("]")
	#print("Connections: ", connections)
	for connection in connections:
		for from_node in graphEdit.get_children():
			if from_node.get("nodeID") == connection[1]:
				for to_node in graphEdit.get_children():
					if to_node.get("nodeID") == connection[2]:
						graphEdit.connect_node(str(from_node.name), connection[0], str(to_node.name), 0)
	return unhandledNodes

func _object_processing(object, graphEdit, connections, transitionValues, payloadValues):
			match object.attributes.class:
				"hkRootLevelContainer": # Done
					print("hkRootLevelContainer loaded.")
					var loadedNode = globalVariable.hkRootLevelContainer.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].children[0].children[2].content != "null":
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].children[0].children[2].content.replace("#",""))])
					graphEdit.add_child(loadedNode)
				"hkbBehaviorGraph": # Done
					print("hkbBehaviorGraph loaded.")
					var loadedNode = globalVariable.hkbBehaviorGraph.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.nodeName = object.children[2].content
					if object.children[4].content != "null":
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[4].content.replace("#",""))])
					graphEdit.add_child(loadedNode)
				"hkbBehaviorGraphData": # Done
					print("hkbBehaviorGraphData loaded.")
				"hkbVariableValueSet": # Done
					print("hkbVariableValueSet loaded.")
				"hkbBehaviorGraphStringData": # Done
					print("hkbBehaviorGraphStringData loaded.")
				"hkbStateMachine": # Done
					print("hkbStateMachine loaded.")
					var loadedNode = globalVariable.hkbStateMachine.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.eventId = int(object.children[3].children[0].children[0].content)
					if object.children[3].children[0].children[1].content != "null": # payload object
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
				"hkbStateMachineStateInfo": # Done
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
				"hkbStateMachineTransitionInfoArray": # Done
					print("hkbStateMachineTransitionInfoArray loaded.")
					var loadedNode = globalVariable.hkbStateMachineTransitionInfoArray.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.transitionArray = []
					for transition in range(int(object.children[0].attributes.numelements)):
						var transitionData = {
							"eventId": int(object.children[0].children[transition].children[4].content),
							"toStateId": int(object.children[0].children[transition].children[5].content),
							"fromNestedStateId": int(object.children[0].children[transition].children[6].content),
							"toNestedStateId": int(object.children[0].children[transition].children[7].content),
							"priority": int(object.children[0].children[transition].children[8].content),
							"flags": [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false],
							"transition": 0,
							"triggerInterval": 0, # TODO: Finish Implementation
							"initiateInterval": 0 # TODO: Finish Implementation
						}
						if object.children[0].children[transition].children[2].content != "null": # transition
							for transitionObject in transitionValues:
								if transitionObject[0] == object.children[0].children[transition].children[2].content:
									transitionData.transition = transitionObject[1] - 1
						for flagsValue in object.children[0].children[transition].children[9].content.split("|"):
							match flagsValue:
								"FLAG_USE_TRIGGER_INTERVAL":
									transitionData.flags[0] = true
								"FLAG_USE_INITIATE_INTERVAL":
									transitionData.flags[1] = true
								"FLAG_UNINTERRUPTIBLE_WHILE_PLAYING":
									transitionData.flags[2] = true
								"FLAG_UNINTERRUPTIBLE_WHILE_DELAYED":
									transitionData.flags[3] = true
								"FLAG_DELAY_STATE_CHANGE":
									transitionData.flags[4] = true
								"FLAG_DISABLED":
									transitionData.flags[5] = true
								"FLAG_DISALLOW_RETURN_TO_PREVIOUS_STATE":
									transitionData.flags[6] = true
								"FLAG_DISALLOW_RANDOM_TRANSITION":
									transitionData.flags[7] = true
								"FLAG_DISABLE_CONDITION":
									transitionData.flags[8] = true
								"FLAG_ALLOW_SELF_TRANSITION_BY_TRANSITION_FROM_ANY_STATE":
									transitionData.flags[9] = true
								"FLAG_IS_GLOBAL_WILDCARD":
									transitionData.flags[10] = true
								"FLAG_IS_LOCAL_WILDCARD":
									transitionData.flags[11] = true
								"FLAG_FROM_NESTED_STATE_ID_IS_VALID":
									transitionData.flags[12] = true
								"FLAG_TO_NESTED_STATE_ID_IS_VALID":
									transitionData.flags[13] = true
								"FLAG_ABUT_AT_END_OF_FROM_GENERATOR":
									transitionData.flags[14] = true
						loadedNode.transitionArray.append(transitionData)
					graphEdit.add_child(loadedNode)
				"hkbStateMachineEventPropertyArray": # Done
					print("hkbStateMachineEventPropertyArray loaded.")
					var loadedNode = globalVariable.hkbStateMachineEventPropertyArray.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.eventsArray = []
					for event in range(int(object.children[0].attributes.numelements)):
						var eventData = {
							"eventID": int(object.children[0].children[event].children[0].content),
							"payloadID": 0
						}
						if object.children[0].children[event].children[1].content != "null": # payload object
							for payload in payloadValues:
								if payload[0] == object.children[0].children[event].children[1].content:
									eventData.payloadID = payload[1]
						else:
							eventData.payloadID = -1
						loadedNode.eventsArray.append(eventData)
					graphEdit.add_child(loadedNode)
				"hkbModifierGenerator": # Done
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
				"hkbModifierList": # Done
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
				"hkbGetUpModifier": # Done
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
				"hkbKeyframeBonesModifier": # Done
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
				"hkbBoneIndexArray": # Done
					print("hkbBoneIndexArray loaded.")
					var loadedNode = globalVariable.hkbBoneIndexArray.instantiate()
					base_node_values(loadedNode, object)
					if object.children[1].content != "null": # boneIndices
						for bone in object.children[1].content.replace("\r\n"," ").split(" "):
							if bone:
								loadedNode.boneIndices.append(int(bone))
					graphEdit.add_child(loadedNode)
				"hkbBoneWeightArray": # Done
					print("hkbBoneWeightArray loaded.")
					var loadedNode = globalVariable.hkbBoneWeightArray.instantiate()
					base_node_values(loadedNode, object)
					if object.children[1].content != "null": # boneWeights
						for bone in object.children[1].content.replace("\r\n"," ").split(" "):
							if bone:
								loadedNode.boneWeights.append(bone)
					graphEdit.add_child(loadedNode)
				"hkbRigidBodyRagdollControlsModifier": # Done
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
				"BSIsActiveModifier": # Done
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
				"hkbVariableBindingSet": # Done
					print("hkbVariableBindingSet loaded.")
					var loadedNode = globalVariable.hkbVariableBindingSet.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.bindingArray = []
					for binding in range(int(object.children[0].attributes.numelements)):
						var bindingData = {
							"memberPath": object.children[0].children[binding].children[0].content,
							"variableIndex": int(object.children[0].children[binding].children[1].content),
							"bindingType": object.children[0].children[binding].children[3].content
						}
						loadedNode.bindingArray.append(bindingData)
					loadedNode.indexOfBindingToEnable	= int(object.children[1].content)
					graphEdit.add_child(loadedNode)
				"hkbManualSelectorGenerator": # Done
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
					if object.children[7].content != "null": # transition effect object
						for transition in transitionValues:
							if transition[0] == object.children[7].content:
								loadedNode.generatorChangedTransitionEffect = transition[1]
					else:
						loadedNode.generatorChangedTransitionEffect = -1
					graphEdit.add_child(loadedNode)
				"BSModifyOnceModifier": # Done
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
				"hkbEvaluateExpressionModifier": # Done
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
				"hkbExpressionDataArray": # Done
					print("hkbExpressionDataArray loaded.")
					var loadedNode = globalVariable.hkbExpressionDataArray.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.expressionArray = []
					for expression in range(int(object.children[0].attributes.numelements)):
						var expressionData = {
							"expression": object.children[0].children[expression].children[0].content,
							"assignmentVariableIndex": int(object.children[0].children[expression].children[1].content),
							"assignmentEventIndex": int(object.children[0].children[expression].children[2].content)
						}
						loadedNode.expressionArray.append(expressionData)
					graphEdit.add_child(loadedNode)
				"hkbPoseMatchingGenerator": # Done
					print("hkbPoseMatchingGenerator loaded.")
					var loadedNode = globalVariable.hkbPoseMatchingGenerator.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData				 = int(object.children[1].content)
					loadedNode.nodeName				 = object.children[2].content
					loadedNode.blendParameter		 = object.children[4].content
					loadedNode.blendSpeed			 = object.children[12].content
					loadedNode.minSpeedToSwitch		 = object.children[13].content
					if object.children[10].content != "null": # children
						for child in object.children[10].content.split("#"):
							if child:
								connections.append([1, int(object.attributes.name.replace("#","")), int(child)])
					loadedNode.startPlayingEventId	 = int(object.children[16].content)
					loadedNode.startMatchingEventId	 = int(object.children[17].content)
					loadedNode.rootBoneIndex		 = int(object.children[18].content)
					loadedNode.otherBoneIndex		 = int(object.children[19].content)
					loadedNode.anotherBoneIndex		 = int(object.children[20].content)
					loadedNode.pelvisIndex			 = int(object.children[21].content)
					graphEdit.add_child(loadedNode)
				"hkbBlenderGenerator": # Done
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
				"hkbBlenderGeneratorChild": # Done
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
				"hkbClipGenerator": # Done
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
				"hkbClipTriggerArray": # Done
					print("hkbClipTriggerArray loaded.")
					var loadedNode = globalVariable.hkbClipTriggerArray.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.triggersArray = []
					for trigger in range(int(object.children[0].attributes.numelements)):
						var triggerData = {
							"localTime": object.children[0].children[trigger].children[0].content,
							"eventID": int(object.children[0].children[trigger].children[1].children[0].children[0].content),
							"payloadID": 0,
							"relativeToEndOfClip": string_to_bool(object.children[0].children[trigger].children[2].content),
							"acyclic": string_to_bool(object.children[0].children[trigger].children[3].content),
							"isAnnotation": string_to_bool(object.children[0].children[trigger].children[4].content)
						}
						if object.children[0].children[trigger].children[1].children[0].children[1].content != "null": # payload object
							for payload in payloadValues:
								if payload[0] == object.children[0].children[trigger].children[1].children[0].children[1].content:
									triggerData.payloadID = payload[1]
						loadedNode.triggersArray.append(triggerData)
					graphEdit.add_child(loadedNode)
				"hkbBlendingTransitionEffect": # Done
					print("hkbBlendingTransitionEffect loaded.")
				"hkbEventDrivenModifier": # Done
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
				"hkbPoweredRagdollControlsModifier": # Done
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
				"hkbTimerModifier": # Done
					print("hkbTimerModifier loaded.")
					var loadedNode = globalVariable.hkbTimerModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					loadedNode.alarmTimeSeconds		= object.children[4].content
					loadedNode.eventId = int(object.children[5].children[0].children[0].content)
					if object.children[5].children[0].children[1].content != "null": # payload object
						for payload in payloadValues:
							if payload[0] == object.children[5].children[0].children[1].content:
								loadedNode.payload = payload[1]
					else:
						loadedNode.payload = -1
					graphEdit.add_child(loadedNode)
				#"BSLookAtModifier":
					#print("BSLookAtModifier loaded.")
				"BSGetTimeStepModifier": # Done
					print("BSGetTimeStepModifier loaded.")
					var loadedNode = globalVariable.BSGetTimeStepModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					loadedNode.timeStep = object.children[4].content
					graphEdit.add_child(loadedNode)
				"hkbTwistModifier": # Done
					print("hkbTwistModifier loaded.")
					var loadedNode = globalVariable.hkbTwistModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData 				 = int(object.children[1].content)
					loadedNode.nodeName 				 = object.children[2].content
					loadedNode.enable 					 = string_to_bool(object.children[3].content)
					loadedNode.axisOfRotation			 = object.children[4].content
					loadedNode.twistAngle				 = object.children[5].content
					loadedNode.startBoneIndex			 = int(object.children[6].content)
					loadedNode.endBoneIndex				 = int(object.children[7].content)
					if object.children[8].content == "RAMPED":
						loadedNode.setAngleMethod = 1
					else:
						loadedNode.setAngleMethod = 0
					if object.children[9].content == "ROTATION_AXIS_IN_MODEL_COORDINATES":
						loadedNode.rotationAxisCoordinates = 1
					elif object.children[9].content == "ROTATION_AXIS_IN_PARENT_COORDINATES":
						loadedNode.rotationAxisCoordinates = 2
					else:
						loadedNode.rotationAxisCoordinates = 0
					loadedNode.isAdditive				 = string_to_bool(object.children[10].content)
					graphEdit.add_child(loadedNode)
				"BSInterpValueModifier": # Done
					print("BSInterpValueModifier loaded.")
					var loadedNode = globalVariable.BSInterpValueModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					loadedNode.source					 = object.children[4].content
					loadedNode.target					 = object.children[5].content
					loadedNode.result					 = object.children[6].content
					loadedNode.gain						 = object.children[7].content
					graphEdit.add_child(loadedNode)
				"hkbEventsFromRangeModifier": # Done
					print("hkbEventsFromRangeModifier loaded.")
					var loadedNode = globalVariable.hkbEventsFromRangeModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					loadedNode.inputValue				 = object.children[4].content
					loadedNode.lowerBound				 = object.children[5].content
					if object.children[6].content != "null": # eventRanges
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[6].content.replace("#",""))])
					graphEdit.add_child(loadedNode)
				"hkbEventRangeDataArray": # Done
					print("hkbEventRangeDataArray loaded.")
					var loadedNode = globalVariable.hkbEventRangeDataArray.instantiate()
					base_node_values(loadedNode, object)
					loadedNode.rangeArray = []
					for eventRange in range(int(object.children[0].attributes.numelements)):
						var rangeData = {
							"upperBound": object.children[0].children[eventRange].children[0].content,
							"eventID": int(object.children[0].children[eventRange].children[1].children[0].children[0].content),
							"payloadID": 0,
							"eventMode": 0,
						}
						if object.children[0].children[eventRange].children[1].children[0].children[1].content != "null": # payload object
							for payload in payloadValues:
								if payload[0] == object.children[0].children[eventRange].children[1].children[0].children[1].content:
									rangeData.payloadID = payload[1]
						if object.children[0].children[eventRange].children[2].content == "EVENT_MODE_SEND_WHEN_IN_RANGE":
							rangeData.eventMode = 1
						loadedNode.rangeArray.append(rangeData)
					#loadedNode.rangeArray				 = node.rangeArray
					graphEdit.add_child(loadedNode)
				"BSBehaviorGraphSwapGenerator": # Done
					print("BSBehaviorGraphSwapGenerator loaded.")
					var loadedNode = globalVariable.BSBehaviorGraphSwapGenerator.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content != "null": # pDefaultGenerator
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[3].content.replace("#",""))])
					graphEdit.add_child(loadedNode)
				"BSCyclicBlendTransitionGenerator": # Done
					print("BSCyclicBlendTransitionGenerator loaded.")
					var loadedNode = globalVariable.BSCyclicBlendTransitionGenerator.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content != "null": # pBlenderGenerator
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[3].content.replace("#",""))])
					
					loadedNode.EventToFreezeBlendValueID = int(object.children[4].children[0].children[0].content)
					if object.children[4].children[0].children[1].content != "null": # EventToFreezeBlend
						for payload in payloadValues:
							if payload[0] == object.children[4].children[0].children[1].content:
								loadedNode.EventToFreezeBlendValuePayload = payload[1]
					else:
						loadedNode.EventToFreezeBlendValuePayload = -1
					
					loadedNode.EventToCrossBlendID = int(object.children[5].children[0].children[0].content)
					if object.children[5].children[0].children[1].content != "null": # EventToCrossBlend
						for payload in payloadValues:
							if payload[0] == object.children[5].children[0].children[1].content:
								loadedNode.EventToCrossBlendPayload = payload[1]
					else:
						loadedNode.EventToCrossBlendPayload = -1
					
					loadedNode.TransitionOutEventID = int(object.children[6].children[0].children[0].content)
					if object.children[6].children[0].children[1].content != "null": # TransitionOut
						for payload in payloadValues:
							if payload[0] == object.children[6].children[0].children[1].content:
								loadedNode.TransitionOutEventPayload = payload[1]
					else:
						loadedNode.TransitionOutEventPayload = -1
					
					loadedNode.TransitionInEventID = int(object.children[7].children[0].children[0].content)
					if object.children[7].children[0].children[1].content != "null": # TransitionIn
						for payload in payloadValues:
							if payload[0] == object.children[7].children[0].children[1].content:
								loadedNode.TransitionInEventPayload = payload[1]
					else:
						loadedNode.TransitionInEventPayload = -1
					loadedNode.fTransitionDuration				 = object.children[9].content
					graphEdit.add_child(loadedNode)
				"BGSGamebryoSequenceGenerator": # Done
					print("BGSGamebryoSequenceGenerator loaded.")
					var loadedNode = globalVariable.BGSGamebryoSequenceGenerator.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData 			= int(object.children[1].content)
					loadedNode.nodeName 			= object.children[2].content
					loadedNode.pSequence			= object.children[3].content
					loadedNode.eBlendModeFunction	= object.children[4].content
					loadedNode.fPercent				= object.children[5].content
					loadedNode.eUseTimePercentage	= object.children[6].content
					loadedNode.fTimePercent			= object.children[7].content
					graphEdit.add_child(loadedNode)
				"hkbBehaviorReferenceGenerator": # Done
					print("hkbBehaviorReferenceGenerator loaded.")
					var loadedNode = globalVariable.hkbBehaviorReferenceGenerator.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData 				= int(object.children[1].content)
					loadedNode.nodeName 				= object.children[2].content
					loadedNode.behaviorName				= object.children[3].content
					graphEdit.add_child(loadedNode)
				"BSAssignVariablesModifier": # Done
					print("BSAssignVariablesModifier loaded.")
					var loadedNode = globalVariable.BSAssignVariablesModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					loadedNode.floatVariable		= [object.children[4].content, object.children[6].content, object.children[8].content, object.children[10].content, object.children[12].content, object.children[14].content, object.children[16].content, object.children[18].content, object.children[20].content, object.children[22].content, object.children[24].content, object.children[26].content, object.children[28].content, object.children[30].content, object.children[32].content, object.children[34].content, object.children[36].content, object.children[38].content, object.children[40].content, object.children[42].content]
					loadedNode.floatValue			= [object.children[5].content, object.children[7].content, object.children[9].content, object.children[11].content, object.children[13].content, object.children[15].content, object.children[17].content, object.children[19].content, object.children[21].content, object.children[23].content, object.children[25].content, object.children[27].content, object.children[29].content, object.children[31].content, object.children[33].content, object.children[35].content, object.children[37].content, object.children[39].content, object.children[41].content, object.children[43].content]
					loadedNode.intVariable			= [int(object.children[44].content), int(object.children[46].content), int(object.children[48].content), int(object.children[50].content)]
					loadedNode.intValue				= [int(object.children[45].content), int(object.children[47].content), int(object.children[49].content), int(object.children[51].content)]
					graphEdit.add_child(loadedNode)
				"DynamicAnimationTaggingGenerator": # Done
					print("DynamicAnimationTaggingGenerator loaded.")
					var loadedNode = globalVariable.DynamicAnimationTaggingGenerator.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content != "null": # pDefaultGenerator
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[3].content.replace("#",""))])
					graphEdit.add_child(loadedNode)
				"BSTimerModifier": # Done
					print("BSTimerModifier loaded.")
					var loadedNode = globalVariable.BSTimerModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					loadedNode.alarmTimeSeconds		= object.children[4].content
					loadedNode.eventId = int(object.children[5].children[0].children[0].content)
					if object.children[5].children[0].children[1].content != "null": # EventToFreezeBlend
						for payload in payloadValues:
							if payload[0] == object.children[5].children[0].children[1].content:
								loadedNode.payload = payload[1]
					else:
						loadedNode.payload = -1
					loadedNode.resetAlarm			= string_to_bool(object.children[6].content)
					graphEdit.add_child(loadedNode)
				"hkbGeneratorTransitionEffect": # Done
					print("hkbGeneratorTransitionEffect loaded.")
					var loadedNode = globalVariable.hkbGeneratorTransitionEffect.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					if object.children[3].content == "SELF_TRANSITION_MODE_CONTINUE":
						loadedNode.selfTransitionMode = 1
					elif object.children[3].content == "SELF_TRANSITION_MODE_RESET":
						loadedNode.selfTransitionMode = 2
					elif object.children[3].content == "SELF_TRANSITION_MODE_BLEND":
						loadedNode.selfTransitionMode = 3
					else:
						loadedNode.selfTransitionMode = 0
					if object.children[4].content == "EVENT_MODE_PROCESS_ALL":
						loadedNode.eventMode = 1
					elif object.children[4].content == "EVENT_MODE_IGNORE_FROM_GENERATOR":
						loadedNode.eventMode = 2
					elif object.children[4].content == "EVENT_MODE_IGNORE_TO_GENERATOR":
						loadedNode.eventMode = 3
					else:
						loadedNode.eventMode = 0
					if object.children[5].content != "null": # transitionGenerator
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[5].content.replace("#",""))])
					loadedNode.blendInDuration			= object.children[6].content
					loadedNode.blendOutDuration			= object.children[7].content
					loadedNode.syncToGeneratorStartTime	= string_to_bool(object.children[8].content)
					graphEdit.add_child(loadedNode)
				"hkbStringEventPayload": # Done
					print("hkbStringEventPayload loaded.")
				"hkbReferencePoseGenerator": # Done
					print("hkbReferencePoseGenerator loaded.")
					var loadedNode = globalVariable.hkbReferencePoseGenerator.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					graphEdit.add_child(loadedNode)
				"hkbDampingModifier": # Done
					print("hkbDampingModifier loaded.")
					var loadedNode = globalVariable.hkbDampingModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					loadedNode.kP = object.children[4].content
					loadedNode.kI = object.children[5].content
					loadedNode.kD = object.children[6].content
					loadedNode.enableScalarDamping = string_to_bool(object.children[7].content)
					loadedNode.enableVectorDamping = string_to_bool(object.children[8].content)
					loadedNode.rawValue = object.children[9].content
					loadedNode.dampedValue = object.children[10].content
					loadedNode.rawVector = object.children[11].content
					loadedNode.dampedVector = object.children[12].content
					loadedNode.vecErrorSum = object.children[13].content
					loadedNode.vecPreviousError = object.children[14].content
					loadedNode.errorSum = object.children[15].content
					loadedNode.previousError = object.children[16].content
					graphEdit.add_child(loadedNode)
				"BSRagdollContactListenerModifier": # Done
					print("BSRagdollContactListenerModifier loaded.")
					var loadedNode = globalVariable.BSRagdollContactListenerModifier.instantiate()
					base_node_values(loadedNode, object)
					if object.children[0].content != "null": # variableBindingSet
						connections.append([0, int(object.attributes.name.replace("#","")), int(object.children[0].content.replace("#",""))])
					loadedNode.userData = int(object.children[1].content)
					loadedNode.nodeName = object.children[2].content
					loadedNode.enable = string_to_bool(object.children[3].content)
					loadedNode.eventId = int(object.children[4].children[0].children[0].content)
					if object.children[4].children[0].children[1].content != "null": # payload object
						for payload in payloadValues:
							if payload[0] == object.children[4].children[0].children[1].content:
								loadedNode.payload = payload[1]
					else:
						loadedNode.payload = -1
					if object.children[5].content != "null": # bones
						connections.append([1, int(object.attributes.name.replace("#","")), int(object.children[5].content.replace("#",""))])
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

func import_values(rootNode, variableBoundPadding):
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
	#print(hkbBehaviorGraphData.children[1].content)
	if hkbBehaviorGraphData.children[1].attributes.has("numelements"):
		#print("Variable Number: ",hkbBehaviorGraphData.children[1].attributes.numelements)
		var quadValues = []
		for quad in hkbVariableValueSet.children[1].content.replace("\r\n"," ").split(" "):
			if quad:
				quadValues.append(quad)
				#print(quad)
		var quadCounter = 0
		var boundsTotal = int(hkbBehaviorGraphData.children[4].attributes.numelements)
		var boundsPaddingIterative = 0
		var boundsCounterIterative = 0
		var boundsCounter = boundsTotal - 1
		print("Bounds Padding: ", variableBoundPadding)
		print("Quad Values: ", quadValues)
		print("Bounds Counter: ", boundsCounter)
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
				variableData.variableValue = str(u32_to_float(int(hkbVariableValueSet.children[0].children[variableNum].children[0].content)))
			elif hkbBehaviorGraphData.children[1].children[variableNum].children[1].content == "VARIABLE_TYPE_POINTER":
				variableData.variableType = 5
			elif hkbBehaviorGraphData.children[1].children[variableNum].children[1].content == "VARIABLE_TYPE_VECTOR4":
				variableData.variableType = 6
				variableData.variableQuadValues = ""
				variableData.variableQuadValues += quadValues[quadCounter] + " "
				quadCounter += 1
				variableData.variableQuadValues += quadValues[quadCounter] + " "
				quadCounter += 1
				variableData.variableQuadValues += quadValues[quadCounter] + " "
				quadCounter += 1
				variableData.variableQuadValues += quadValues[quadCounter]
				quadCounter += 1
			elif hkbBehaviorGraphData.children[1].children[variableNum].children[1].content == "VARIABLE_TYPE_QUATERNION":
				variableData.variableType = 7
				variableData.variableQuadValues = ""
				variableData.variableQuadValues += quadValues[quadCounter] + " "
				quadCounter += 1
				variableData.variableQuadValues += quadValues[quadCounter] + " "
				quadCounter += 1
				variableData.variableQuadValues += quadValues[quadCounter] + " "
				quadCounter += 1
				variableData.variableQuadValues += quadValues[quadCounter]
				quadCounter += 1
			print(variableData.variableID, " - ", variableData.variableName)
			if boundsPaddingIterative == variableBoundPadding or boundsPaddingIterative > variableBoundPadding:
				if boundsTotal != 0 && boundsCounterIterative != boundsCounter:
					print("Bounds left: ", boundsCounter - boundsCounterIterative, "Padding Left: ", boundsPaddingIterative)
					variableData.variableMinValue = str(u32_to_float(int(hkbBehaviorGraphData.children[4].children[boundsCounterIterative].children[0].children[0].children[0].content)))
					variableData.variableMaxValue = str(u32_to_float(int(hkbBehaviorGraphData.children[4].children[boundsCounterIterative].children[1].children[0].children[0].content)))
					boundsCounterIterative += 1
				else:
					print("No bounds left.")
			else:
				boundsPaddingIterative += 1
				print("Padding Bound. Bounds left: ", boundsCounter - boundsCounterIterative)
			globalVariable.globalVariableList.append(variableData)
	if hkbBehaviorGraphData.children[2].attributes.has("numelements"):
		for propertiesNum in range(int(hkbBehaviorGraphData.children[2].attributes.numelements)):
			var propertiesData = {
					"propertiesID": propertiesNum,
					"propertiesName": hkbBehaviorGraphStringData.children[3].children[propertiesNum].content,
					"propertiesType": 0
				}
			if hkbBehaviorGraphData.children[2].children[propertiesNum].children[1].content == "VARIABLE_TYPE_BOOL":
				propertiesData.propertiesType = 0
			elif hkbBehaviorGraphData.children[2].children[propertiesNum].children[1].content == "VARIABLE_TYPE_INT8":
				propertiesData.propertiesType = 1
			elif hkbBehaviorGraphData.children[2].children[propertiesNum].children[1].content == "VARIABLE_TYPE_INT16":
				propertiesData.propertiesType = 2
			elif hkbBehaviorGraphData.children[2].children[propertiesNum].children[1].content == "VARIABLE_TYPE_INT32":
				propertiesData.propertiesType = 3
			elif hkbBehaviorGraphData.children[2].children[propertiesNum].children[1].content == "VARIABLE_TYPE_REAL":
				propertiesData.propertiesType = 4
			elif hkbBehaviorGraphData.children[2].children[propertiesNum].children[1].content == "VARIABLE_TYPE_POINTER":
				propertiesData.propertiesType = 5
			elif hkbBehaviorGraphData.children[2].children[propertiesNum].children[1].content == "VARIABLE_TYPE_VECTOR4":
				propertiesData.propertiesType = 6
			elif hkbBehaviorGraphData.children[2].children[propertiesNum].children[1].content == "VARIABLE_TYPE_QUATERNION":
				propertiesData.propertiesType = 7
			globalVariable.globalPropertiesList.append(propertiesData)
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

func u32_to_float(value: int):
	var byte_array = PackedByteArray()
	byte_array.resize(4)
	byte_array.encode_u32(0, value)
	var float_value = byte_array.decode_float(0)
	return 	float_value
