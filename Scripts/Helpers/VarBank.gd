## Helper script to allow easy access to variables anywhere,
## Also default keeps a history of values to allow for rollbacks or getting the default.
extends Node

var Vars: Dictionary[String, Array] = {}

## Initialize new variable
## WILL OVERWRITE OLD VARS IF ALREADY EXISTS
func initVar(varName: String, default: Variant):
	if Vars.has(varName):
		Vars.erase(varName)
	Vars[varName] = [default]

## Set new value of given variable
func setVar(varName: String, newVal: Variant):
	if !Vars.has(varName): return
	Vars[varName].append(newVal)

## Gets the current value of given variable, or go back x amount
func getVar(varName: String, index: int = 0) -> Variant:
	if !Vars.has(varName): return null
	return Vars[varName][Vars[varName].size() - 1 - index]

## Gets variable names matching the given string
func getMatch(matchString: String) -> Variant:
	return Vars.keys().filter(func(e: String): return e.match(matchString))

## Rolls back the variable value to the last set value or by a custom amount
func rollBack(varName: String, amount: int = 1):
	if !Vars.has(varName) or Vars[varName].size() <= 1: return
	if Vars[varName].size() - 1 < amount: 
		resetVar(varName)
		return
	Vars[varName] = Vars[varName].slice(0, Vars[varName].size() - amount)

## Reset variable with given name
func resetVar(varName: String):
	if !Vars.has(varName): return
	Vars[varName] = [Vars[varName][0]]

## Reset variables that matches the given expression
func resetMatch(matchString: String):
	var matching = Vars.keys().filter(func(e: String): return e.match(matchString))
	for matched in matching:
		resetVar(matched)
