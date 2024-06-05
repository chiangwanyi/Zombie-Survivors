class_name SpellItem extends Resource

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
	Melee
}

@export var id: String
@export var name: String
@export var texture: Texture2D

@export_group("Spell Attributes")
## 可使用次数（为负数表示无使用次数限制）
@export var uses: int = -1
## 能量消耗
@export var energe_drain: int = 5
## 对两个法术施放之间的时间的【修正】
@export var cast_delay: float = 0
## 对武器充能时间的【修正】
@export var recharge_time: float = 0
## 法术类型
@export var spell_type: SpellType
## 抽取数变量
@export var draw_num: int = 0
## 伤害类型
@export var damage_type: DamageType
## 伤害量
@export var damage: int
