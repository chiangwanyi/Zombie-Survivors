class_name Projectile2D extends Area2D

enum ProjectileTrajectory {
	## 直线弹道
	LINEAR,
	## 抛物线弹道
	PARABOLIC,         
	## 自动追踪弹道
	HOMING,            
	## 反弹弹道
	BOUNCING,          
	## 分裂弹道
	SPLITTING,         
	## 激光（瞬时命中）
	LASER,             
	## 范围效果（例如爆炸）
	AREA_OF_EFFECT,    
	## 受重力影响的弹道
	GRAVITY_AFFECTED   
}
# 目标位置
@export var target_position: Vector2
# 速度
@export var speed: float = 200.0
@export var trajectory: ProjectileTrajectory = ProjectileTrajectory.LINEAR

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	($StateMachine as StateMachine).start()
