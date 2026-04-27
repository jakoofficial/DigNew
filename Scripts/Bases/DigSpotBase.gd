@abstract class_name DigSpot
extends Area2D

@export var _Name: String = ""
@export var _SpriteFrame: int = 3
var _Ore
var is_hovered: bool = false

@abstract
func Destroy() -> void
@abstract
func GiveOre() -> void
@abstract
func Spawn() -> void
