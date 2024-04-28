class_name DamageOnTouch extends Area2D

# 【伤害施放节点】的Health
var damage_taken_health: Health
# 【伤害承受节点】的Health
var collider_health: Health

# 是否持续施加伤害
var repeat_damage_over_time: bool = false
# 伤害持续施加的时间间隔（秒）
var duration_between_repeats: float = 1

var min_damage_caused: float = 10
var max_damage_caused: float = 10

var attack_interval: float = 0

func attack(delta: float) -> void:
	if collider_health == null:
		return
		
	if collider_health.can_take_damage_this_frame():
		var random_damage = randf_range(min_damage_caused, maxf(max_damage_caused, min_damage_caused))
		
		if not repeat_damage_over_time:
			collider_health.take_damage(random_damage, owner, 0.5)
		else:
			if attack_interval == 0:
				collider_health.take_damage(random_damage, owner, 0.5)
				attack_interval += delta
			elif attack_interval > duration_between_repeats:
				attack_interval = 0
			else:
				attack_interval += delta
			
