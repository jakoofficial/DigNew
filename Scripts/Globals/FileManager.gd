extends Node

var path: String = "user://DigSave.save"
var CurrSaveFile = null

func SaveData():
	var dict = {
		"filename": "DigSave.save",
		"Stamina": PS.Stamina,
		"StaminaMax": PS._PStaminaMax,
		"Balance": PS._PBalance,
		"Strength": PS._PStrength,
		"ValueBonus": PS._PValueBonus,
		"MaxSpotsX": GM.xSpots,
		"MaxSpotsY": GM.ySpots,
		"Skills": SkillTreeInfo.Skills
	}
	return dict

func SaveGame() -> void:
	var file = FileAccess.open(path, FileAccess.WRITE)
	
	var json_string = JSON.stringify(SaveData())
	file.store_line(json_string)
	file.close()

func NewGameFile() -> void:
	var file = FileAccess.file_exists(path)
	if file:
		DirAccess.remove_absolute(path)
		SaveGame()
		return
	else:
		SaveGame()

func CheckSaveGame() -> bool:
	if not FileAccess.file_exists(path): return false
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
