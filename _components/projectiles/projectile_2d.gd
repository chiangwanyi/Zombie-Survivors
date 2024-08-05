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

@onready var state_machine: StateMachine = $StateMachine
@onready var hit_delay_timer: Timer = $HitDelayTimer
@onready var damage_on_touch_ability: DamageOnTouchAbility = $DamageOnTouchAbility

## 目标位置
@export var target_position: Vector2
## 速度
@export var speed: float = 800.0
## 弹道
@export var trajectory: ProjectileTrajectory = ProjectileTrajectory.LINEAR
## 伤害延迟计算时间（为0则表示碰到敌人后立即计算伤害）
@export var hit_delay_time: float = 0.0

var waiting_damage_area_list: Array[Area2D] = []

var body_gravity: float
var body_drag: float
var body_force: float

func _ready() -> void:
    if trajectory == ProjectileTrajectory.GRAVITY_AFFECTED:
        body_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
        body_drag = ProjectSettings.get_setting("physics/2d/default_linear_damp")

    # body_force = speed
    
    state_machine.start()
    
func get_forward_direction() -> Vector2:
    return global_position.direction_to(target_position)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
    state_machine.change_state("Destory")


func _on_health_ability_killed() -> void:
    state_machine.change_state("Destory")


func _on_hit_delay_timer_timeout() -> void:
    state_machine.change_state("Hit")
