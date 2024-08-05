class_name Spell extends Node

enum SpellType {
    Projectile,
    StaticProjectile,
    Passive,
    Utility,
    ProjectileModifier,
    Multicast
}

enum DamageType {
    ## 投射物伤害
    Projectile,
    ## 穿凿伤害
    Drill,
    ## 近战伤害
    Melee,
    ## 爆炸伤害
    Explosion
}

@export_group("Spell Attributes")
@export var spell_name: String

## 可使用次数（为负数表示无使用次数限制）
var uses: int = -1
## 能量消耗
var energy_drain: int = 5
## 法术类型
@export var spell_type: SpellType
## 伤害量
var damage: int
## 伤害类型
@export var damage_type: DamageType
## 伤害范围半径
var damage_radius: int
## 发射最小初速度
var min_speed: float
## 发射最大初速度
var max_speed: float
## 投射物数量
var projectile_count: int = 1
## 持续时间
var lifetime: int = -1
## 对两个法术施放之间的时间的【修正】
var cast_delay: float = 0
## 对武器充能时间的【修正】
var recharge_delay: float = 0
## 生存时间
var lifetime_change: float = 0
## 散射角度
var spread_degrees: int = -1
## 暴击率
var damage_critical: int
## 速度加成
var speed_multiplier: float = 1
## 抽取数变量
var draw_num: int = 0


@export var projectile_scene: PackedScene

var projectile_modifier_spells: Array[Spell] = []

func cast(start_position: Vector2, target_position: Vector2, force: float) -> void:
    var projectile = projectile_scene.instantiate() as Projectile2D
    projectile.body_force = force
    projectile.global_position = start_position
    projectile.target_position = target_position
    GameManager.current_level.call_deferred("add_child", projectile)

func spawn_projectile() -> Projectile2D:
    var projectile = projectile_scene.instantiate() as Projectile2D
    return projectile

static func get_spell_name(value):
    if value is Spell:
        var modifier_list: Array[Spell] = value.projectile_modifier_spells
        if not modifier_list.is_empty():
            return value.spell_name + "(" + str(modifier_list.map(Spell.get_spell_name)) + ")"
        return value.spell_name
    elif value is Array:
        return value.map(Spell.get_spell_name)
    return "NONE"    
