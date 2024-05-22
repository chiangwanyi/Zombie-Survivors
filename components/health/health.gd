class_name Health extends Node

signal damaged
signal killed

## 节点的初始HP
@export var initial_health: float = 10

## 节点的当前HP
var current_health: float

## 如果为true，则当前节点无法受到伤害
var in_vulnerable: bool
var destory_on_death: bool = true

func _ready() -> void:
	_set_health(initial_health)

func _set_health(hp: float) -> void:
	current_health = hp

func _can_take_damage_this_frame() -> bool:
	if in_vulnerable:
		return false
	
	if current_health <= 0 and initial_health != 0:
		return false
	return true

func take_damage(damage: float, _instigator: Node, _invincibility_duration: float) -> void:
	if not _can_take_damage_this_frame():
		return
	
	damage = _compute_damage_output(damage)
	
	_set_health(current_health - damage)
	damaged.emit()
	
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
	killed.emit()
