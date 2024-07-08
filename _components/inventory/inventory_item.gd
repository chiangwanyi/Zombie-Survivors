class_name InventoryItem extends Control

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

## 所属 Inventory 名称，用于通知
var inventory_name: String = ""

func _get_drag_data(_at_position: Vector2) -> Variant:
    if not is_draggable:
        return null
    visible = false
    var item := duplicate() as InventoryItem
    item.position = Vector2.ZERO
    item.visible = true
    set_drag_preview(item)
    item.tree_exited.connect(func (): 
        visible = true
        # (GameManager.inventories[inventory_name] as InventoryBasicAbility).item_sync.emit()
        )
    return self
    
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
    # 用来拖动交换两个 InventoryItem
    if data is InventoryItem and is_swappable and data.item_type_name == item_type_name:
        return true
    return false

# 当两个 item 发生交换时
func _drop_data(_at_position: Vector2, data: Variant) -> void:
    if data is InventoryItem:
        # 等待通知的 Inventory
        var call_inventories := []

        var item = self as InventoryItem
        var item_parent = item.get_parent()
        
        reparent(data.get_parent())
        data.visible = true
        data.reparent(item_parent)
        
        if not call_inventories.has(data.inventory_name):
            call_inventories.append(data.inventory_name)
        if not call_inventories.has(item.inventory_name):
            call_inventories.append(item.inventory_name)

        for value in call_inventories:
            (GameManager.inventories[value] as InventoryBasicAbility).item_sync.emit()
