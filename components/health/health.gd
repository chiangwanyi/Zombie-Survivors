@icon("res://components/health/health.svg")
class_name Health extends Node

# 节点的当前HP
var current_health: float
# 节点的初始HP
var initial_health: float = 10
# 节点的最大HP
#var maximum_health: float = 10

# 如果为true，则当前节点无法受到伤害
var in_vulnerable: bool

var destory_on_death: bool = true

func _init(init_health: float, invincible: bool) -> void:
	initial_health = init_health
	in_vulnerable = invincible
	name = "Health"
	
	initialize_current_health()

func initialize_current_health() -> void:
	set_health(initial_health)
	
func set_health(new_value: float) -> void:
	current_health = new_value
	#UpdateHealthBar(false);
	#HealthChangeEvent.Trigger(this, newValue);
	
func can_take_damage_this_frame() -> bool:
	if in_vulnerable:
		return false
	
	if current_health <= 0 and initial_health != 0:
		return false
	return true

func take_damage(damage: float, instigator: Node2D, invincibility_duration: float) -> void:
	if not can_take_damage_this_frame():
		return
		
	damage = compute_damage_output(damage)
	
	set_health(current_health - damage)
		
func compute_damage_output(damage: float) -> float :
	if in_vulnerable:
		return 0
	var total_damage = 0
	
	# TODO
	total_damage += damage
	
	return total_damage
