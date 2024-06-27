class_name InventoryItem extends Control

@export var inventory_name: String = ""
## 区分 InventoryItem 的类别
@export var item_type_name: String = ""
## InventoryItem 的名字
@export var item_name: String = ""
## InventoryItem 的描述
@export var item_description: String = ""

## 是否可拖拽
@export var is_draggable: bool = true
## 是否可交换
@export var is_swappable: bool = true

func _get_drag_data(_at_position: Vector2) -> Variant:
    if not is_draggable:
        return null
    visible = false
    var item := duplicate() as InventoryItem
    item.position = Vector2.ZERO
    item.visible = true
    #item.scale = Vector2(2, 2)
    set_drag_preview(item)
    item.tree_exited.connect(func (): 
        visible = true
        (GameManager.inventories[inventory_name] as InventoryBasicAbility).item_sync.emit())
    return self
    
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
    # 用来拖动交换两个 InventoryItem
    if data is InventoryItem and is_swappable and data.item_type_name == item_type_name:
        return true
    return false
    
func _drop_data(_at_position: Vector2, data: Variant) -> void:
    if data is InventoryItem:
        var item = self as InventoryItem
        var item_parent = item.get_parent()
        
        reparent(data.get_parent())
        data.visible = true
        data.reparent(item_parent)
