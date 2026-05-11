@abstract class_name DigSpot
extends Area2D

@export var _Name: String = "Block"
@export var _SpriteFrame: int = 0
@export var _Texture: AtlasTexture

@export var _Health: int = 2
@export var _Value: int = 1

@export var _Sounds: Array

var is_hovered: bool = false

@abstract
func Destroy() -> void
@abstract
func GiveValue() -> void
@abstract
func Spawn() -> void
