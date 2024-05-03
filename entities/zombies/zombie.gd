class_name Zombie extends DamageableArea2D

var state_machine: StateMachine
var damage_area: DamageOnTouch

# 当前追逐的植物
var target_plant : Plant
# 移动速度
var speed : float = 20.0 * 0.1
