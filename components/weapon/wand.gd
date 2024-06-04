class_name Wand extends Weapon

#enum TriggerModes { SemiAuto, Auto }

@onready var slots: Node = $Slots

### 是否自动开火
#@export var auto_shoot: bool = false
### 开火模式
#@export var trigger_mode: TriggerModes = TriggerModes.Auto

var state_machine: StateMachine

@export_group("Wand Statistics")
## 容量
@export var capacity: int = 4
## 施放数
@export var max_cast: int = 1
## 施放延迟
@export var cast_delay: float = 0.5
## 充能时间
@export var recharge_time: float = 0.6
## 最大武器能量值
@export var max_energe: int = 100
## 每秒回复的能量值
@export var energe_recharge_speed: int = 10

## 当前剩余能量值
@export var energe: float
### 当前剩余施放数
#@export var cast: int

## 【法术槽】
var spells: Array[Spell]

## 【牌库】
var deck: Array[Spell]
## 【手牌】
var hand: Array[Spell]
## 【弃牌库】
var discared: Array[Spell]

var current_cast_group: Array[Spell]
var cast_group_stack: Array = []

func _ready() -> void:
	energe = max_energe
	var i = 0
	for child in slots.get_children():
		if i >= capacity:
			break
		if child is Spell:
			spells.append(child)
			#deck.append(child)
			i += 1
			print("Wand:%s Slot[%d/%d]装载：{Name:%s\t, SpellType:%s}" 
			% [name, i, capacity, child.name, child.spell_type])
	reset()
	state_machine = $StateMachine as StateMachine
	state_machine.start()

func reset() -> void:
	deck.clear()
	for s in spells:
		deck.append(s)
	hand.clear()
	discared.clear()
	cast_group_stack.clear()
	
func recharge(delta: float) -> void:
	if energe < max_energe:
		print("%s 恢复 energe [%f/%f]" % [name, energe, max_energe])
		# 计算在这个特定帧的时间内应当恢复多少 energe
		# delta 的单位是秒。如果delta是0.016秒（约等于60帧/秒），
		# 那么每帧应该恢复的 energe 为 10 * 0.016 = 0.16 点。
		energe += energe_recharge_speed * delta
		energe = min(energe, max_energe)
