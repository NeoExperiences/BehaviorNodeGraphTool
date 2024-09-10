extends Node


# Global Values
@export var globalTransitionList: Array = []
@export var globalEventList: Array = []
@export var globalPayloadList: Array = []
@export var globalPropertiesList: Array = []
@export var globalVariableList: Array = []

# Theme Colors
var defaultTheme = load("res://Resources/Themes/Default_Theme.tres")
var blueTheme = load("res://Resources/Themes/Blue_Theme.tres")
var deepBlueTheme = load("res://Resources/Themes/DeepBlue_Theme.tres")
var redTheme = load("res://Resources/Themes/Red_Theme.tres")
var purpleTheme = load("res://Resources/Themes/Purple_Theme.tres")
var eggplantTheme = load("res://Resources/Themes/Eggplant_Theme.tres")
var emeraldTheme = load("res://Resources/Themes/Emerald_Theme.tres")
var greenTheme = load("res://Resources/Themes/Green_Theme.tres")
var brownTheme = load("res://Resources/Themes/Brown_Theme.tres")
var orangeTheme = load("res://Resources/Themes/Orange_Theme.tres")
var yellowTheme = load("res://Resources/Themes/Yellow_Theme.tres")
var ceruleanTheme = load("res://Resources/Themes/Cerulean_Theme.tres")


# Scene Loading
var BGSGamebryoSequenceGenerator			= load("res://Nodes/BGSGamebryoSequenceGeneratorScene.tscn")
var BSIsActiveModifier						= load("res://Nodes/BS/BSIsActiveModifierScene.tscn")
var hkRootLevelContainer					= load("res://Nodes/hkRootLevelContainerScene.tscn")
var hkbBehaviorGraph						= load("res://Nodes/hkbB/hkbBehaviorGraphScene.tscn")
var hkbGeneratorTransitionEffect			= load("res://Nodes/hkbG/hkbGeneratorTransitionEffectScene.tscn")
var hkbGetUpModifier						= load("res://Nodes/hkbG/hkbGetUpModifierScene.tscn")
var hkbModifierGenerator					= load("res://Nodes/hkbM/hkbModifierGeneratorScene.tscn")
var hkbModifierList							= load("res://Nodes/hkbM/hkbModifierListScene.tscn")
var hkbStateMachine							= load("res://Nodes/hkbS/hkbStateMachineScene.tscn")
var hkbStateMachineEventPropertyArray		= load("res://Nodes/hkbS/hkbStateMachineEventPropertyArrayScene.tscn")
var hkbStateMachineStateInfo				= load("res://Nodes/hkbS/hkbStateMachineStateInfoScene.tscn")
var hkbStateMachineTransitionInfoArray		= load("res://Nodes/hkbS/hkbStateMachineTransitionInfoArrayScene.tscn")
var hkbReferencePoseGenerator				= load("res://Nodes/hkbR/hkbReferencePoseGeneratorScene.tscn")
var hkbVariableBindingSet					= load("res://Nodes/hkbVariableBindingSetScene.tscn")
var hkbManualSelectorGenerator				= load("res://Nodes/hkbM/hkbManualSelectorGeneratorScene.tscn")
var hkbKeyframeBonesModifier 				= load("res://Nodes/hkbKeyframeBonesModifierScene.tscn")
var hkbBoneIndexArray 						= load("res://Nodes/hkbB/hkbBoneIndexArrayScene.tscn")
var hkbBoneWeightArray						= load("res://Nodes/hkbB/hkbBoneWeightArrayScene.tscn")
var hkbRigidBodyRagdollControlsModifier 	= load("res://Nodes/hkbR/hkbRigidBodyRagdollControlsModifierScene.tscn")
var BSModifyOnceModifier					= load("res://Nodes/BS/BSModifyOnceModifierScene.tscn")
var hkbEvaluateExpressionModifier			= load("res://Nodes/hkbE/hkbEvaluateExpressionModifierScene.tscn")
var hkbExpressionDataArray					= load("res://Nodes/hkbE/hkbExpressionDataArrayScene.tscn")
var hkbPoseMatchingGenerator				= load("res://Nodes/hkbP/hkbPoseMatchingGeneratorScene.tscn")
var hkbBlenderGenerator						= load("res://Nodes/hkbB/hkbBlenderGeneratorScene.tscn")
var hkbBlenderGeneratorChild				= load("res://Nodes/hkbB/hkbBlenderGeneratorChildScene.tscn")
var hkbClipGenerator						= load("res://Nodes/hkbC/hkbClipGeneratorScene.tscn")
var hkbClipTriggerArray						= load("res://Nodes/hkbC/hkbClipTriggerArrayScene.tscn")
var hkbTimerModifier						= load("res://Nodes/hkbT/hkbTimerModifierScene.tscn")
var hkbEventDrivenModifier					= load("res://Nodes/hkbE/hkbEventDrivenModifierScene.tscn")
var hkbPoweredRagdollControlsModifier 		= load("res://Nodes/hkbP/hkbPoweredRagdollControlsModifierScene.tscn")
var BSGetTimeStepModifier					= load("res://Nodes/BS/BSGetTimeStepModifierScene.tscn")
var hkbTwistModifier						= load("res://Nodes/hkbT/hkbTwistModifierScene.tscn")
var BSInterpValueModifier					= load("res://Nodes/BS/BSInterpValueModifierScene.tscn")
var hkbEventsFromRangeModifier				= load("res://Nodes/hkbE/hkbEventsFromRangeModifierScene.tscn")
var hkbEventRangeDataArray					= load("res://Nodes/hkbE/hkbEventRangeDataArrayScene.tscn")
var BSBehaviorGraphSwapGenerator			= load("res://Nodes/BS/BSBehaviorGraphSwapGeneratorScene.tscn")
var hkbBehaviorReferenceGenerator			= load("res://Nodes/hkbB/hkbBehaviorReferenceGeneratorScene.tscn")
var BSAssignVariablesModifier				= load("res://Nodes/BS/BSAssignVariablesModifierScene.tscn")
var DynamicAnimationTaggingGenerator		= load("res://Nodes/DynamicAnimationTaggingGeneratorScene.tscn")
var BSTimerModifier							= load("res://Nodes/BS/BSTimerModifierScene.tscn")
var BSCyclicBlendTransitionGenerator		= load("res://Nodes/BS/BSCyclicBlendTransitionGeneratorScene.tscn")
var hkbDampingModifier						= load("res://Nodes/hkbDampingModifierScene.tscn")
var BSRagdollContactListenerModifier		= load("res://Nodes/BS/BSRagdollContactListenerModifierScene.tscn")
var hkbLayer								= load("res://Nodes/hkbL/hkbLayerScene.tscn")
var hkbLayerGenerator						= load("res://Nodes/hkbL/hkbLayerGeneratorScene.tscn")
var BSiStateTaggingGenerator				= load("res://Nodes/BS/BSiStateTaggingGeneratorScene.tscn")
