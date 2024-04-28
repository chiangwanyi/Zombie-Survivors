class_name Zombie extends Area2D

var health: Health
var state_machine: StateMachine
var animation: AnimatedSprite2D
var damage_area: DamageOnTouch

# 当前追逐的植物
var target_plant : Plant
# 移动速度
var speed : float = 20.0
