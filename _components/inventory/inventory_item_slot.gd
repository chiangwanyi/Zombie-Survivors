class_name InventoryItemSlot extends PanelContainer

## 是否可拖拽
@export var can_drop: bool = true

## 所属 Inventory 名称，用于通知
var inventory_name: String = ""

## 是否允许其他 Node 拖动到该 Node 上
func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
    return can_drop

func _drop_data(_at_position: Vector2, data: Variant) -> void:
    if data is InventoryItem:
        data.visible = true
        if get_child_count() == 0:
            data.reparent(self)
        (GameManager.inventories[inventory_name] as InventoryBasicAbility).item_sync.emit()

## 获取背包物品，即第一个子节点，如果没有则返回 null
func get_item() -> InventoryItem:
    if has_item():
        return get_child(0)
    return null

func has_item() -> bool:
    var t = get_child_count()
    return t > 0

## （安全地）装载背包物品
func push_item_safe(inventory_item: InventoryItem) -> void:
    if get_child_count() == 0:
        if inventory_item.get_parent():
            inventory_item.reparent(self)
        else:
            call_deferred("add_child", inventory_item)
            #add_child(inventory_item)
        inventory_item.visible = true
