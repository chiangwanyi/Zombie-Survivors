class_name Health extends Node

## HP的所属者
var body: DamageableArea2D
## 节点的当前HP
var current_health: float
## 节点的初始HP
var initial_health: float = 10

## 如果为true，则当前节点无法受到伤害
var in_vulnerable: bool

var destory_on_death: bool = true

func _init(init_health: float, invincible: bool, node: DamageableArea2D) -> void:
	initial_health = init_health
	in_vulnerable = invincible
	body = node
	name = "Health"
	
	_initialize_current_health()

func _initialize_current_health() -> void:
	_set_health(initial_health)
	
func _set_health(new_value: float) -> void:
	current_health = new_value
	#UpdateHealthBar(false);
	#HealthChangeEvent.Trigger(this, newValue);

func _can_take_damage_this_frame() -> bool:
	if in_vulnerable:
		return false
	
	if current_health <= 0 and initial_health != 0:
		return false
	return true

func take_damage(damage: float, instigator: Node, invincibility_duration: float) -> void:
	if not _can_take_damage_this_frame():
		return
	
	damage = _compute_damage_output(damage)
	
	_set_health(current_health - damage)
	
	if current_health <= 0:
		_kill()
		
func _compute_damage_output(damage: float) -> float :
	if in_vulnerable:
		return 0
	var total_damage = 0
	
	# TODO
	total_damage += damage
	
	return total_damage

func _kill() -> void:
	body.killed.emit()
