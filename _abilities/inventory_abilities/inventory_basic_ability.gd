class_name InventoryBasicAbility extends InventoryAbility

signal item_sync

## 背包在 GameManager 中注册的名称
@export var inventory_name: String
## 是否生成随机的 Inventory 注册名称，多用于动态生成的节点
@export var random_inventory_name: bool
## Inventory 的所属类，必填
@export var inventory_type: String
## 背包大小
@export var slot_size = 0
## 背包槽位 Scene
@export var slot_scene: PackedScene
## 背包挂载的 Container
@export var inventory_container: Container

## 背包 item_slot 列表
var item_slot_list : Array[InventoryItemSlot] = []
## 背包 item_name 列表
@export var item_name_list := []

func _ready() -> void:
    if random_inventory_name:
        inventory_name = IdUtils.unique_key(16)
    GameManager.inventories[inventory_name] = self

    item_sync.connect(_on_item_sync)
        

## 重载背包，背包数据自动从 config.json 中读取
func reload(size := -1) -> void :
    if size > 0:
        slot_size = size

    if slot_size < 0:
        slot_size = 0
        
    var cfg_level := GameManager.cfg_levels.get(GameManager.current_level_name) as Dictionary
    var inventory := (cfg_level.get("inventories") as Dictionary).get(inventory_name, {}) as Dictionary
    if inventory.is_empty():
        return
    var type = inventory.get("inventory_type")
    if not inventory_type:
        return
    # 背包物品 Array[String]
    var inventory_items = inventory.get("inventory_items", [])
    
    if slot_size == 0:
        slot_size = inventory_items.size()
    reset_items(type, inventory_items)
        

## 重载背包，并同时插入物品（并非从 config.json 中读取）
func reload_with_items(list: Array, size := -1) -> void :
    if size > 0:
        slot_size = size

    if slot_size < 0:
        slot_size = 0

    clean_slots(slot_size)
    reset_items(inventory_type, list)


## 向背包的指定槽位插入物品
func set_item(slot_index: int, item: InventoryItem) -> void :
    if slot_index < 0 or slot_index >= slot_size:
        return
    
    item_slot_list[slot_index].push_item_safe(item)

func get_item(slot_index: int) -> InventoryItem :
    if slot_index < 0 or slot_index >= slot_size:
        return null
    return (item_slot_list[slot_index] as InventoryItemSlot).get_item()


func reset_items(type: String, item_list: Array) -> void :
    item_name_list = item_list

    clean_slots()

    for i in range(slot_size):
        if i < item_name_list.size():
            var item_name := item_name_list[i] as String
            if item_name:
                var item_map := GameManager.inventory_item_dict.get(type) as Dictionary
                var item := (item_map.get(item_name) as PackedScene).instantiate() as InventoryItem

                item.inventory_name = inventory_name
                item.item_type_name = type
                item.item_name = item_name
                set_item(i, item)


func clean_slots(size := -1) -> void :
    for i in range(inventory_container.get_child_count()):
        inventory_container.get_child(i).queue_free()

    item_slot_list.clear()
    
    if size > 0 and slot_size != size:
        slot_size = size
        
    # 根据 slot_size 数，添加 n 个 slot_scene 的节点
    for i in range(slot_size):
        var slot = slot_scene.instantiate() as InventoryItemSlot
        item_slot_list.append(slot)
        inventory_container.add_child(slot)

func _on_item_sync() -> void :
    var new_item_name_list := []
    for slot in item_slot_list:
        if slot.has_item():
            new_item_name_list.append(slot.get_item().item_name)
        else:
            new_item_name_list.append("")
    item_name_list = new_item_name_list
