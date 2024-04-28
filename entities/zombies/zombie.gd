class_name Zombie extends DamageableArea2D

var animation: AnimatedSprite2D
var damage_area: DamageOnTouch

# 当前追逐的植物
var target_plant : Plant
# 移动速度
var speed : float = 20.0

func on_target_plant_died() -> void:
	state_machine._change_state(&"idle")
