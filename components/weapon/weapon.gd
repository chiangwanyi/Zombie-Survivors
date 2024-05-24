class_name Weapon extends Node2D

enum TriggerModes { SemiAuto, Auto }

## 是否自动开火
@export var auto_trigger: bool = false
## 开火模式
@export var trigger_mode: TriggerModes = TriggerModes.Auto
## 每次使用的延迟（秒）
@export_range(0.1, 10, 0.1) var time_between_used: float = 1

var weapon_abilities: Array[WeaponAbility]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is WeaponAbility:
			weapon_abilities.append(child)
	
	($StateMachine as StateMachine).start()
