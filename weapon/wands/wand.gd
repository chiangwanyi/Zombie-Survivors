class_name Wand extends Weapon

enum TriggerModes { SemiAuto, Auto }

@onready var state_machine: StateMachine = $StateMachine

## 武器重装条
@export var wand_recharge_bar : ProgressBar
## 武器能量条
@export var wand_energy_bar: ProgressBar
@export var weapon_aim_point: Marker2D

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
@export var energe: float = float(max_energe)

@export_group("Spells")
@export var spell_inventory: InventoryBasicAbility

## 【法术槽】
var spell_list: Array[Spell]

## 【牌库】
var deck: Array[Spell]
## 【手牌】
var hand: Array[Spell]
## 【弃牌库】
var discared: Array[Spell]

var current_cast_group: Array[Spell]
var cast_group_stack: Array = []

func _ready() -> void:
    # 2. 开始
    state_machine.start()


# 由植物初始化时调用
func reset_spell_list() -> void:
    spell_list.clear()
    
    spell_list.resize(spell_inventory.item_name_list.size())
    for i in range(spell_inventory.item_name_list.size()):
        var spell_name = spell_inventory.item_name_list[i]
        if spell_name:
            var spell = (GameManager.registed_spells[spell_name] as Spell).copy()
            spell_list[i] = spell            
    reload()

func reload() -> void:
    deck.clear()
    for spell in spell_list:
        if spell:
            deck.append(spell)
    hand.clear()
    discared.clear()
    cast_group_stack.clear()
    
    turn_off()
    
func recharge(delta: float) -> void:
    if energe < max_energe:
        #print("%s 恢复 energe [%f/%f]" % [name, energe, max_energe])
        # 计算在这个特定帧的时间内应当恢复多少 energe
        # delta 的单位是秒。如果delta是0.016秒（约等于60帧/秒），
        # 那么每帧应该恢复的 energe 为 10 * 0.016 = 0.16 点。
        energe += energe_recharge_speed * delta
        energe = min(energe, max_energe)

        wand_energy_bar.visible = true
        wand_energy_bar.value = lerp(0, 100, energe / max_energe)
    else:
        wand_energy_bar.visible = false
        
