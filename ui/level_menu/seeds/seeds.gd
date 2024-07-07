extends HBoxContainer

@onready var inventory_basic_ability: InventoryBasicAbility = $InventoryBasicAbility

@onready var title: Label = $InfoPanel/Panel/Panel/Title
@onready var description: Label = $InfoPanel/Panel/Panel/Description

func _ready() -> void:
    inventory_basic_ability.reload()
    # 因为 item_slot 插入 item 是空闲时执行，因此 seed_packet 的初始化也要空闲时执行
    call_deferred("_init_seeds")

## 初始化 Seed 
func _init_seeds() -> void:
    var cfg_level := GameManager.cfg_levels.get(GameManager.current_level_name) as Dictionary
    var inventory := (cfg_level.get("inventories") as Dictionary).get(inventory_basic_ability.inventory_name) as Dictionary
    var inventory_items = inventory.get("inventory_items", [])
    for i in range(inventory_items.size()):
        if inventory_items[i]:
            # 将 seed_name 转换为小写，并且将空格替换为下划线
            var seed_avatar_name = inventory_items[i].to_lower().replace(" ", "_")
            var seed_packet_slot = inventory_basic_ability.item_slot_list[i]
            if seed_packet_slot.has_item():
                var seed_packet_item := inventory_basic_ability.item_slot_list[i].get_item() as SeedPacketItem
                var seed_info := GameManager.cfg_seeds[inventory_items[i]] as Dictionary
                seed_packet_item.item_name = inventory_items[i]
                seed_packet_item.cost = seed_info.get("cost")
                seed_packet_item.reset_profile(seed_avatar_name)

func on_seed_packet_hover(seed_name: String) -> void:
    var seed_info := GameManager.cfg_seeds[seed_name] as Dictionary
    title.text = seed_info.get("name")
    description.text = seed_info.get("description")
