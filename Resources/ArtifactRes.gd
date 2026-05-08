class_name ArtifactRes
extends Resource

@export var _ArtifactTexture: AtlasTexture
@export var _ArtifactLevelIcon: AtlasTexture
@export var _Name: String = "Artifact"
@export_multiline() var _Description: String = ""
@export var _Value: int = 1
##Look in GM for actual Level names (Will break if non selected)
@export var _Level: String = ""
@export var _HasBeenCollected: bool = false
@export var _CollectedAmount: int = 0
