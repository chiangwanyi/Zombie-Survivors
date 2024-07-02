class_name HealthAbility extends Ability

signal damaged
signal killed

## 节点的初始HP
@export var initial_health: int = 10
## HP 条
@export var hp_bar: ProgressBar

## 节点的当前HP
var current_health: int

## 如果为true，则当前节点无法受到伤害
var in_vulnerable: bool
var destory_on_death: bool = true

func _ready() -> void:
    _set_health(initial_health)

func _set_health(hp: int) -> void:
    current_health = hp
    if hp_bar:
        hp_bar.visible = true
        hp_bar.value = lerp(0, 100, current_health * 1.0 / initial_health)

func _can_take_damage_this_frame() -> bool:
    if in_vulnerable:
        return false
    
    if current_health <= 0 and initial_health != 0:
        return false
    return true

#func take_damage(damage: int, _instigator: Node, _invincibility_duration: float) -> void:
func take_damage(damage: int) -> void:
    if not _can_take_damage_this_frame():
        return
    
    damage = _compute_damage_output(damage)
    
    _set_health(current_health - damage)
    damaged.emit()
    
    if current_health <= 0:
        _kill()
        
func _compute_damage_output(damage: int) -> int :
    if in_vulnerable:
        return 0
    var total_damage = 0
    
    # TODO
    total_damage += damage
    
    return total_damage

func _kill() -> void:
    killed.emit()
