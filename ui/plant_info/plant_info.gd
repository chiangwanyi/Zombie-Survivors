extends Panel

@onready var plant_name: Label = $VBoxContainer/HBoxContainer/Name
@onready var plant_cast: Label = $VBoxContainer/HBoxContainer2/Cast
@onready var energe: Label = $VBoxContainer/HBoxContainer3/Energe

@onready var avatar: TextureRect = $Avatar

@onready var basic_inventory_ability: InventoryBasicAbility = $BasicInventoryAbility


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    visible = false
    basic_inventory_ability.reload(-1)

# 由被点击的【植物】调用
func show_info(pn: String, wand: Wand) -> void:
    plant_name.text = GameManager.cfg_seeds[pn].description
    avatar.texture = load("res://_assets/images/plants/%s.png" % pn)
    basic_inventory_ability.reload(wand.capacity)
    visible = true
