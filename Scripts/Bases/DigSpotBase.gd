@abstract class_name DigSpot
extends Area2D

@export var _Name: String = ""
@export var _SpriteFrame: int = 3
var _Ore

@abstract
func Destroy() -> void
@abstract
func GiveOre() -> void
