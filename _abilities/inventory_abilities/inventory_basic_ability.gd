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

func _ready() -> void:
    if random_inventory_name:
        inventory_name = IdUtils.unique_key(16)
    GameManager.inventories[inventory_name] = self
        

## 重载背包
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
        

## 重载背包，并同时插入物品
func reload_with_items(size: int, list: Array[InventoryItem]) -> void :
    reload(size)
    # 调用 set_item 插入物品
    for i in range(list.size()):
        set_item(i, list[i])


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
    clean_slots()

    for i in range(slot_size):
        if i < item_list.size():
            var item_name := item_list[i] as String
            if item_name:
                var item_map := GameManager.inventory_item_dict.get(type) as Dictionary
                var item := (item_map.get(item_name) as PackedScene).instantiate() as InventoryItem

                item.inventory_name = inventory_name
                item.item_type_name = type
                item.item_name = item_name
                set_item(i, item)


func clean_slots() -> void :
    for i in range(inventory_container.get_child_count()):
        inventory_container.get_child(i).queue_free()

    item_slot_list.clear()
        
    # 根据 slot_size 数，添加 n 个 slot_scene 的节点
    for i in range(slot_size):
        var slot = slot_scene.instantiate() as InventoryItemSlot
        item_slot_list.append(slot)
        inventory_container.add_child(slot)
