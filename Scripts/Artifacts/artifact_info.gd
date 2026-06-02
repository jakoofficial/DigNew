class_name ArtifactCollection
extends Node2D

@export var Artifacts:Array[ArtifactRes]

var Artifacts_Copy:Array[ArtifactRes]

var artifact_dict: Dictionary[String, int]

func get_artifact(a_Name: String) -> ArtifactRes:
	if a_Name != "":
		return Artifacts_Copy[artifact_dict[a_Name]]
	return null

func _ready() -> void:
	_generate()
	
func _generate() -> void:
	artifact_dict.clear()
	Artifacts_Copy = Artifacts.duplicate_deep()
	
	for i in range(Artifacts_Copy.size()):
		artifact_dict[Artifacts_Copy[i]._Name] = i

func Collect(a: ArtifactRes) -> void:
	for i in range(Artifacts_Copy.size()):
		if Artifacts_Copy[i]._Name == a._Name:
			Artifacts_Copy[i]._CollectedAmount+=1
		
			if !Artifacts_Copy[i]._HasBeenCollected:
				Artifacts_Copy[i]._HasBeenCollected = true
				var AllCollected: bool = true
				for j in GM.Artifacts[a._Level]:
					if !ArtifactInfo.get_artifact(j)._HasBeenCollected: AllCollected = false
				if AllCollected and !GM.levelMastery.has(a._Level):
					GM.levelMastery[a._Level] = true
			FM.SaveGame()


func Load(savedArtifacts: Array[ArtifactRes]) -> void:
	_generate()
	Artifacts_Copy = savedArtifacts
