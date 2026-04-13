## Basic helper script for easier management of actions
## Relies on FancyKey/FancyKeyObj and VarBank
extends Node

var _pre = "Actions_"

func initAction(actionName: String, ...defaultKeys: Array):
	VB.initVar(str(_pre, actionName), defaultKeys)
	VB.setVar(str(_pre, actionName), VB.getVar(str(_pre, actionName)).duplicate())

func action(actionName: String):
	return VB.getVar(str(_pre, actionName))

func update(actionName: String, newKey: FancyKeyObj, idx: int = 0):
	VB.getVar(str(_pre, actionName))[idx] = newKey

func default(actionName: String):
	VB.resetVar(str(_pre, actionName))
	VB.setVar(str(_pre, actionName), VB.getVar(str(_pre, actionName)).duplicate())

func defaultAll():
	VB.resetMatch(str(_pre, "*"))
	for matched in VB.getMatch(str(_pre, "*")):
		VB.setVar(matched, VB.getVar(matched).duplicate())

## Returns all actions
func getActions() -> Array[String]:
	return VB.getMatch(str(_pre, "*"))
