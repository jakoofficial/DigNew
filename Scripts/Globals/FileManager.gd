extends Node

var path: String = "user://DigSave.save"
var CurrSaveFile = null

func SaveData():
	var dict = {
		"filename": "DigSave.save",
		"LastPlayed": Time.get_datetime_dict_from_system(true),
		"StaminaMax": PS._PStaminaMax,
		"Balance": PS._PBalance,
		"Strength": PS._PStrength,
		"ValueBonus": PS._PValueBonus,
		"DigGridAmount": PS._PDigGridAmount,
		"MaxSpotsX": GM.xSpots,
		"MaxSpotsY": GM.ySpots,
		"ArtifactPermit": GM.canFindArtifacts,
		"ArtifactChance": GM.artifactChance,
		"ArtifactBonusPercent": GM.artifactBonusPercent,
		"ArtifactCollection": ArtifactInfo.Artifacts_Copy,
		"Skills": SkillTreeInfo.skillsArrCopy,
		"LevelSelection": GM.LevelSelectDict,
		"Settings": Settings.settings_dict,
	}
	return dict

func SaveGame() -> void:
	var file = FileAccess.open(path, FileAccess.WRITE)
	
	var json_string = JSON.stringify(JSON.from_native(SaveData(), true), " ")
	file.store_line(json_string)
	file.close()

func NewGameFile() -> void:
	PS.BaseValues()
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
	CurrSaveFile = JSON.to_native(JSON.parse_string(json_text), true)
	if !CurrSaveFile == null:
		file.close()
		return CurrSaveFile 
	file.close()
