class_name Weapon extends Node2D


## 是否按下 trigger
var trigger_pressed: bool = false

func turn_on() -> void:
	trigger_pressed = true

func turn_off() -> void:
	trigger_pressed = false
