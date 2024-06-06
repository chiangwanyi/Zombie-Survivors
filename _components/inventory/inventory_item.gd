class_name InventoryItem extends Control

func _get_drag_data(at_position: Vector2) -> Variant:
	# 复制 self 对象，并将其作为拖动数据返回
	var item_view := self.duplicate() as InventoryItem
	#item_view.custom_minimum_size = self.size * 2
	item_view.modulate.a = 0.5
	item_view.position = Vector2(-at_position)
	
	var control := Control.new()
	control.add_child(item_view)
	set_drag_preview(control)
	return self
