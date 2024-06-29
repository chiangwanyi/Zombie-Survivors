class_name Plant extends Area2D

@onready var state_machine: StateMachine = $StateMachine
@onready var wand: Wand = $Wand
@onready var handle_weapon_ability: CharacterHandleWeaponAbility = $HandleWeaponAbility

@export var key: String
## 攻击速度（两次攻击的间隔时间，单位秒）
@export var attack_speed: float = 1.0:
    set(value):
        if not is_inside_tree():
            await ready
        attack_speed = value
        if handle_weapon_ability:
            handle_weapon_ability.auto_use_timer.wait_time = value
        

var plant_name: String
var target_zombies: Array[Zombie] = []

func _ready() -> void:
    state_machine.start()
    
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    # 右键单击植物，显示植物信息
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
        get_tree().call_group("plant_info", "show_info", key)
