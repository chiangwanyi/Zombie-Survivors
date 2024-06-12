class_name InventoryBasicAbility extends InventoryAbility

## 背包在 GameManager 中注册的名称
@export var inventory_name: String = "Default Inventory"
## 背包大小
@export var size = 0
## 背包槽位 Scene
@export var slot_scene: PackedScene
### 背包物品 Scene
#@export var item_scene: PackedScene
## 背包挂载的 Container
@export var inventory_container: Container

func reload():
    # 清空 inventory_container 的所有子节点
    for i in range(inventory_container.get_child_count()):
        inventory_container.get_child(i).queue_free()
        
    # 根据 size 数，添加 n 个 slot_scene 的节点
    for i in range(size):
        var slot = slot_scene.instantiate()
        inventory_container.add_child(slot)
