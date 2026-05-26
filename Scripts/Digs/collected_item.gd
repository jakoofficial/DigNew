extends HBoxContainer

func Set_Values(item: DigSpot) -> void:
	$ItemTexture.texture = item._Texture
	$ItemName.text = str("%s (%s)" % [item._Name.replace("_", " "), GM.currDigArea.inventory.get(item)])
	$Value.text = str("%s" % [(item._Value*GM.currDigArea.inventory.get(item))])

func Set_Values_Artifact(item: ArtifactRes) -> void:
	$ItemTexture.texture = item._ArtifactLevelIcon
	$ItemName.text = str("%s (%s)" % [item._Name.replace("_", " "), GM.currDigArea.artifact_inv.get(item)])
	
	var value = (GM.artifactBonusPercent*item._Value) if GM.artifactBonusPercent > 1.0 else item._Value
	$Value.text = str("%s" % [int(value*GM.currDigArea.artifact_inv.get(item))])

func Get_Value() -> int:
	return int($Value.text)
