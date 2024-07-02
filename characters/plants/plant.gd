class_name Plant extends Area2D

@onready var state_machine: StateMachine = $StateMachine
@onready var wand: Wand = $Wand
@onready var handle_weapon_ability: CharacterHandleWeaponAbility = $HandleWeaponAbility
@onready var attack_timer: Timer = $AttackTimer


## 是否自动使用武器
@export var auto_attack: bool = false:
    set(value):
        if not is_inside_tree():
            await ready
        auto_attack = value
        attack_timer.one_shot = not value
        if value and attack_timer.is_stopped():
            attack_timer.start()

## 攻击速度（两次攻击的间隔时间，单位秒）
@export var attack_speed: float = 1.0:
    set(value):
        if not is_inside_tree():
            await ready
        attack_speed = value
        if handle_weapon_ability:
            attack_timer.wait_time = value
        
var key: String
var plant_name: String
var target_zombies: Array[String] = []

func _ready() -> void:
    state_machine.start()

# 鼠标动作
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    # 右键单击植物，显示植物信息
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
        get_tree().call_group("plant_info", "show_info", key)

func _on_attack_timer_timeout() -> void:
    if not target_zombies.is_empty():
        state_machine.change_state("Attack")

func remove_target_zombie(zombie_key: String) -> void:
    target_zombies.erase(zombie_key)
