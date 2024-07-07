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
    for i in range(inventory_basic_ability.item_slot_list.size()):
        var seed_packet_slot = inventory_basic_ability.item_slot_list[i]
        if seed_packet_slot and seed_packet_slot.has_item():
            var seed_packet_item := inventory_basic_ability.item_slot_list[i].get_item() as SeedPacketItem
            
            var seed_avatar_name = seed_packet_item.item_name.to_lower().replace(" ", "_")
            var seed_info := GameManager.cfg_seeds[seed_packet_item.item_name] as Dictionary
            seed_packet_item.cost = seed_info.get("cost")
            seed_packet_item.reset_profile(seed_avatar_name)

func on_seed_packet_hover(seed_name: String) -> void:
    var seed_info := GameManager.cfg_seeds[seed_name] as Dictionary
    title.text = seed_info.get("name")
    description.text = seed_info.get("description")
