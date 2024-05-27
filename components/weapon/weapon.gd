class_name Weapon extends Node2D

enum TriggerModes { SemiAuto, Auto }

@onready var slots: Node = $Slots

### 是否自动开火
#@export var auto_shoot: bool = false
### 开火模式
#@export var trigger_mode: TriggerModes = TriggerModes.Auto

var state_machine: StateMachine

## 武器挂载的所有 Spell
var spells: Array[Spell]
## 是否按下 trigger
var trigger_pressed: bool = false

@export_group("Weapon Statistics")
## 容量
@export var capacity: int = 4
## 施放数
@export var cast: int = 1
## 施放延迟
@export var cast_delay: float = 0.5
## 充能时间
@export var recharge_time: float = 0.6
## 最大武器能量值
@export var max_energe: int = 100
## 每秒回复的能量值
@export var energe_recharge_speed: int = 10


func _ready() -> void:
	var i = 0
	# 装载 Spell，不超过 capacity
	for child in slots.get_children():
		if i >= capacity:
			break
		if child is Spell:
			spells.append(child)
			i += 1
	
	state_machine = $StateMachine as StateMachine
	state_machine.start()
	
#func weapon_input_start() -> void:
	#_trigger_pressed = true

func turn_weapon_on() -> void:
	trigger_pressed = true
