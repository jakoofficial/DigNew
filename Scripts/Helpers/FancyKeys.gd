## A helper tool to easily use keycodes the same way you'd use an action
## Whenever you try to use a function the tool will automatically
class_name FKS
extends Node

var StateResetTime: float = .10
enum InputType {Keyboard, Mouse, ControllerButton, ControllerJoy}

var MouseButtonWheelKeys: Array[MouseButton] = [
	MouseButton.MOUSE_BUTTON_WHEEL_DOWN,
	MouseButton.MOUSE_BUTTON_WHEEL_LEFT,
	MouseButton.MOUSE_BUTTON_WHEEL_UP,
	MouseButton.MOUSE_BUTTON_WHEEL_RIGHT
]

var CurrKeyStates: Dictionary[String, Dictionary] = {}

func _ready() -> void:
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and MouseButtonWheelKeys.has(event.button_index):
		var eventToUse: InputEventMouseButton = event
		for key in CurrKeyStates.values().filter(func (e): return e["Key"].type == InputType.Mouse):
			var fancyKeyObject = (key["Key"] as FancyKeyObj)
			if eventToUse.button_index == fancyKeyObject.btn and eventToUse.pressed and key["Pressed"] != true:
				_SetPressed(fancyKeyObject.keycode)

func _process(delta):
	for val in CurrKeyStates.values():
		if (val["Key"] as FancyKeyObj).type == InputType.Mouse and MouseButtonWheelKeys.has((val["Key"] as FancyKeyObj).btn):
			if val["Has_Been_Checked"] or (val["Time_Till_Reset"] != -999 and val["Time_Till_Reset"] <= 0):
				if val["Just_Pressed"] and !val["Just_Set"]: val["Just_Pressed"] = false
				if val["Just_Released"]: val["Just_Released"] = false
				val["Has_Been_Checked"] = false
				val["Time_Till_Reset"] = -999
			elif val["Time_Till_Reset"] != -999:
				val["Time_Till_Reset"] -= delta
		else:
			if val["Has_Been_Checked"] or (val["Time_Till_Reset"] != -999 and val["Time_Till_Reset"] <= 0):
				if val["Just_Pressed"]: val["Just_Pressed"] = false
				if val["Just_Released"]: val["Just_Released"] = false
				val["Has_Been_Checked"] = false
				val["Time_Till_Reset"] = -999
			elif val["Time_Till_Reset"] != -999:
				val["Time_Till_Reset"] -= delta
	
	for key in CurrKeyStates.keys():
		_KeyLogic(key)

func _ValidateKey(key: FancyKeyObj):
	if not CurrKeyStates.has(key.keycode):
		CurrKeyStates[key.keycode] = {
			"Key": key,
			"Pressed": false,
			"Just_Set": false,
			"Just_Pressed": false,
			"Just_Released": false,
			"Has_Been_Checked": false,
			"Time_Till_Reset": -999
		}

func _KeyLogic(keycode: String):
	var CurrKey = CurrKeyStates[keycode]
	var KeyObj = CurrKeyStates[keycode]["Key"]
	match KeyObj["type"]:
		InputType.Keyboard:
			if Input.is_key_pressed(KeyObj["btn"]):
				_SetPressed(keycode)
			elif CurrKey["Pressed"] == true:
				_SetReleased(keycode)
		InputType.Mouse: #TODO ADD EXCEPTION FOR MOUSE WHEEL
			if MouseButtonWheelKeys.has(CurrKey["Key"]["btn"]):
				if CurrKey["Pressed"]:
					if !CurrKey["Just_Set"]:
						_SetReleased(keycode)
					else:
						CurrKey["Just_Set"] = false
			else:
				if Input.is_mouse_button_pressed(KeyObj["btn"]):
					_SetPressed(keycode)
				elif CurrKey["Pressed"] == true:
					_SetReleased(keycode)
		InputType.ControllerButton:
			if Input.is_joy_button_pressed(KeyObj["deviceIdx"], KeyObj["btn"]):
				_SetPressed(keycode)
			elif CurrKey["Pressed"]:
				_SetReleased(keycode)

func _SetPressed(keycode: String):
	var CurrKey = CurrKeyStates[keycode]
	if !CurrKey["Pressed"]:
		CurrKey["Just_Pressed"] = true
	CurrKey["Pressed"] = true
	CurrKey["Just_Set"] = true
	CurrKey["Just_Released"] = false
	CurrKey["Time_Till_Reset"] = StateResetTime

func _SetReleased(keycode: String):
	var CurrKey = CurrKeyStates[keycode]
	if CurrKey["Pressed"]:
		CurrKey["Just_Released"] = true
	CurrKey["Pressed"] = false
	CurrKey["Just_Set"] = false
	CurrKey["Just_Pressed"] = false
	CurrKey["Time_Till_Reset"] = StateResetTime

func Pressed(key):
	if key is Array:
		for k in key:
			if k == null: continue
			_ValidateKey(k)
			CurrKeyStates[k.keycode]["Has_Been_Checked"] = true
			if CurrKeyStates[k.keycode]["Pressed"]: return true
		return false
	else:
		_ValidateKey(key)
		CurrKeyStates[key.keycode]["Has_Been_Checked"] = true
		return CurrKeyStates[key.keycode]["Pressed"]

func JustPressed(key):
	if key is Array:
		for k in key:
			if k == null: continue
			_ValidateKey(k)
			CurrKeyStates[k.keycode]["Has_Been_Checked"] = true
			if CurrKeyStates[k.keycode]["Just_Pressed"]: return true
		return false
	else:
		_ValidateKey(key)
		CurrKeyStates[key.keycode]["Has_Been_Checked"] = true
		return CurrKeyStates[key.keycode]["Just_Pressed"]

func JustReleased(key):
	if key is Array:
		for k in key:
			if k == null: continue
			_ValidateKey(k)
			CurrKeyStates[k.keycode]["Has_Been_Checked"] = true
			if CurrKeyStates[k.keycode]["Just_Released"]: return true
		return false
	else:
		_ValidateKey(key)
		CurrKeyStates[key.keycode]["Has_Been_Checked"] = true
		return CurrKeyStates[key.keycode]["Just_Released"]

func Axis(key1, key2 = null):
	if key1 is Array:
		if key1[0].type != InputType.ControllerJoy:
			return ButtonAxis(key1, key2)
		else:
			return JoysAxis(key1)
	else:
		if key1.type != InputType.ControllerJoy:
			return ButtonAxis(key1, key2)
		else:
			return JoysAxis(key1)

func ButtonAxis(key1, key2):
	var val1 = 0
	var val2 = 0
	if key1 is Array:
		for val in key1:
			if val == null: continue
			if Pressed(val):
				val1 = 1
				break
	else:
		val1 = 1 if Pressed(key1) else 0
	
	if key2 is Array:
		for val in key2:
			if val == null: continue
			if Pressed(val):
				val2 = -1
				break
	else:
		val2 = -1 if Pressed(key2) else 0
	
	return val1 + val2

func JoysAxis(key):
	var val: float = 0
	if key is Array:
		for k in key:
			if k == null: continue
			var temp = Input.get_joy_axis(k.deviceIdx, k.btn)
			if temp != 0:
				val = temp
				break
	else:
		val = Input.get_joy_axis(key.deviceIdx, key.btn)
	return val

static func NewKey(_btn: int, _type: FKS.InputType = FK.InputType.Keyboard, _deviceIdx: int = 0) -> FancyKeyObj:
	var newKey = FancyKeyObj.new()
	newKey.btn = _btn
	newKey.type = _type
	newKey.deviceIdx = _deviceIdx
	newKey.keycode = str(FKS.InputType.keys()[_type], ":", _deviceIdx, ":", _btn)
	return newKey
