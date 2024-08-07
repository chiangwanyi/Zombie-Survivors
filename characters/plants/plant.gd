class_name Plant extends Area2D

@onready var state_machine: StateMachine = $StateMachine
@onready var wand: Wand = $Wand
@onready var handle_weapon_ability: CharacterHandleWeaponAbility = $HandleWeaponAbility

#@onready var attack_timer: Timer = $AttackTimer
@onready var inventory_basic_ability: InventoryBasicAbility = $InventoryBasicAbility
## 植物的攻击检测范围 图形
@onready var attack_detection: Polygon2D = $Polygon2D

@onready var sfx_plant: AudioStreamPlayer = $SfxPlant

@export var attack_detection_radius: int = 100

var key: String
var plant_name: String
var target_zombies: Array[String] = []

func _ready() -> void:
    state_machine.start()
    
    hide_attack_detection()
    attack_detection.polygon = PolygonUtils.generate_circle_polygon(attack_detection_radius, 100, Vector2.ZERO)
    
    var seed_info := GameManager.cfg_seeds.get(plant_name) as Dictionary
    inventory_basic_ability.slot_size = seed_info.get("initial_spell_capacity")
    inventory_basic_ability.item_name_list = seed_info.get("initial_spell")
    
    wand.reset_spell_list()
    
    sfx_plant.play()
    

# 鼠标动作
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    # 右键单击植物，显示植物信息
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
        get_tree().call_group("menu_plant", "show_plant_info", key)
        attack_detection.visible = true

## 当僵尸被消灭后，由group调用
func remove_target_zombie(zombie_key: String) -> void:
    target_zombies.erase(zombie_key)
    
func hide_attack_detection() -> void:
    attack_detection.visible = false

func _on_spell_inventory_item_sync() -> void:
    wand.reset_spell_list()
