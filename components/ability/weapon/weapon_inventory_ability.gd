class_name WeaponInventoryAbility extends WeaponAbility

@export var inventory_name: String = "Default Inventory"
@export var size = 0
@export var slot: PackedScene
@export var items: Array[Resource]

func init(s: int) -> void:
	size = s
	if GameManager.inventories.has(inventory_name):
		for i in range(size):
			(GameManager.inventories[inventory_name] as Node).add_child(slot.instantiate())
