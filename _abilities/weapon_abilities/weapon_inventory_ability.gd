class_name WeaponInventoryAbility extends WeaponAbility

@export var inventory_name: String = "Default Inventory"
@export var size = 0
@export var slot: PackedScene
@export var items: Array[PackedScene]

# 初始化函数，用于设置Inventory的大小并根据需要初始化Inventory的槽位。
# @param s Inventory的槽位数量。
func init(s: int) -> void:
	var inventory := GameManager.inventories[inventory_name] as GridContainer
	# 设置Inventory的大小。
	size = s
	
	# 检查GameManager是否已经存在具有相同名称的Inventory。
	if GameManager.inventories.has(inventory_name):
		# 如果存在，遍历槽位数量并为每个槽位创建一个实例。
		for i in range(size):
			var slot_node = slot.instantiate() as InventoryItemSlot
			if items[i]:
				slot_node.add_child((items[i] as PackedScene).instantiate() as InventoryItem)
			# 将新创建的槽位节点添加到已存在的Inventory节点中
			inventory.call_deferred("add_child", slot_node)
