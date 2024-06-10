class_name InventoryItemSlot extends PanelContainer

## 是否允许其他 Node 拖动到该 Node 上
func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
    return true

func _drop_data(_at_position: Vector2, data: Variant) -> void:
    if data is InventoryItem:
        data.visible = true
        if get_child_count() == 0:
            data.reparent(self)
