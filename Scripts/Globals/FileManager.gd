extends Node

var path: String = "user://DigDigSave.save"
var CurrSaveFile = null

func SaveData():
	var dict = {
		"filename": "DigDigSave.save",
		"Stamina": PS.Stamina,
		"Balance": PS.Balance,
		"MaxDigs": PS.MaxDigs,
		"Global_Inventory": PS.Global_Inventory,
		"MaxDigX": PS.MaxDigX,
		"MaxDigY": PS.MaxDigY
	}
	return dict

func SaveGame() -> void:
	var file = FileAccess.open("user://DigDigSave.save", FileAccess.WRITE)
	
	var json_string = JSON.stringify(SaveData())
	file.store_line(json_string)
	file.close()

func NewGameFile() -> void:
	var file = FileAccess.file_exists(path)
	if file:
		DirAccess.remove_absolute(path)
		print("hel")
		SaveGame()
		return
	else:
		SaveGame()

func CheckSaveGame() -> bool:
	if not FileAccess.file_exists("user://DigDigSave.save"): return false
	else: return true

func LoadGame():
	if !CheckSaveGame(): return null
	
	var file = FileAccess.open(path, FileAccess.READ)
	var json_text: String = FileAccess.get_file_as_string(path)
	CurrSaveFile = JSON.parse_string(json_text)
	if !CurrSaveFile == null:
		file.close()
		return CurrSaveFile 
	file.close()
