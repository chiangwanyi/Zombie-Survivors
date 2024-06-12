class_name SeedPacketItem extends InventoryItem

## 【植物种子】Item 的图片
@onready var item_avatar: TextureRect = $ItemAvatar
## 【植物种子】Item 的价格
@onready var cost_label: Label = $CostLabel

@export var cost: int = 500

## 【植物种子】ItemAvatar 文件夹
var _avatar_folder = "res://_assets/images/plants/"        

func _ready() -> void:
    var res = load(_avatar_folder + item_name + ".png")
    if res:
        item_avatar.texture = res
    cost_label.text = str(cost)