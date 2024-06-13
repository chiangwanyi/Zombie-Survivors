class_name SeedPacketItem extends InventoryItem

## 【植物种子】Item 的图片
@onready var item_avatar: TextureRect = $ItemAvatar
## 【植物种子】Item 的价格
@onready var cost_label: Label = $CostLabel
## 【植物种子】Item 的状态机
@onready var state_machine: StateMachine = $StateMachine

@export var cost: int = 500

## 【植物种子】ItemAvatar 文件夹
var _avatar_folder = "res://_assets/images/plants/"        

func _ready() -> void:
    var res = load(_avatar_folder + item_name + ".png")
    if res:
        item_avatar.texture = res
    cost_label.text = str(cost)
    # 启动状态机
    state_machine.start()


func _get_drag_data(_at_position: Vector2) -> Variant:
    if not is_draggable:
        return null
    state_machine.change_state("Dragging")
    var viewr = Control.new()
    viewr.add_child(item_avatar.duplicate())
    set_drag_preview(viewr)
    return self
