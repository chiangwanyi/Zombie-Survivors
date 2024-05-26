class_name Weapon extends Node2D

enum TriggerModes { SemiAuto, Auto }

## 是否自动开火
@export var auto_trigger: bool = false
## 开火模式
@export var trigger_mode: TriggerModes = TriggerModes.Auto
## 每次使用的延迟（秒）
@export var time_between_used: float = 0.1

## 武器属性能力（投射物、近战等）
var weapon_abilities: Array[WeaponAbility]


func _ready() -> void:
	# 装载所有【武器属性能力】
	for child in get_children():
		if child is WeaponAbility:
			weapon_abilities.append(child)
	
	($StateMachine as StateMachine).start()
