class_name Weapon extends Node2D

## 投射类武器的弹道类型
enum ProjectileTrajectory {
	LINEAR,            # 直线弹道
	PARABOLIC,         # 抛物线弹道
	HOMING,            # 自动追踪弹道
	BOUNCING,          # 反弹弹道
	SPLITTING,         # 分裂弹道
	LASER,             # 激光（瞬时命中）
	AREA_OF_EFFECT,    # 范围效果（例如爆炸）
	GRAVITY_AFFECTED   # 受重力影响的弹道
}

## 是否自动开火
@export var auto_fire: bool = false



## 使用武器，direction 是开火方向
func weapon_use(_direction: Vector2) -> void :
	pass
