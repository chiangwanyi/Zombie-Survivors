class_name InventoryItem extends Control

# InventoryItem 的名字
@export var item_name: String = ""
# InventoryItem 的描述
@export var item_description: String = ""

func _get_drag_data(at_position: Vector2) -> Variant:
    visible = false
    var item := duplicate() as InventoryItem
    item.position = Vector2.ZERO
    item.visible = true
    item.scale = Vector2(2, 2)
    set_drag_preview(item)
    return self
    
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
    # 用来拖动交换两个 InventoryItem
    if data is InventoryItem:
        return true
    return false
    
func _drop_data(at_position: Vector2, data: Variant) -> void:
    if data is InventoryItem:
        var item = self as InventoryItem
        var item_parent = item.get_parent()
        
        reparent(data.get_parent())
        data.visible = true
        data.reparent(item_parent)
