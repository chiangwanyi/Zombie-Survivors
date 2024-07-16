class_name Zombie extends Area2D

@onready var state_machine: StateMachine = $StateMachine

var key: String
var zombie_name: String
## 当前的目标植物
var target_plant: Plant

## 移动速度
@export var speed: float = 100

func _ready() -> void:
    state_machine.start()


## 当 Plant 进入僵尸的 Attack Zone 时
func _on_attack_zone_area_entered(_area: Area2D) -> void:
    state_machine.change_state("Attack")


## 当 HP 归零（小于零）时
func _on_health_ability_killed() -> void:
    get_tree().call_group("plant", "remove_target_zombie", key)
    state_machine.change_state("Die")
