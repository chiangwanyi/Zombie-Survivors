extends HBoxContainer

@onready var level_menu: LevelMenu = $"../.."
@onready var tab_container: VBoxContainer = $".."

@onready var plant_title_label: Label = $InfoPanel/Panel/HBoxContainer/Label
@onready var plant_avatar: TextureRect = $InfoPanel/Panel/HBoxContainer/Avatar

## 【植物种子】ItemAvatar 文件夹
var _avatar_folder = "res://_assets/images/plants/"

var current_plant_key: String

func _ready() -> void:
    pass
    
func show_plant_info(plant_key: String) -> void:
    var plant = GameManager.registerd_plants[plant_key] as Plant
    current_plant_key = plant_key
    
    var wand = plant.wand as Wand

    plant_title_label.text = GameManager.cfg_seeds[plant.plant_name].title
    var avatar_name = plant.plant_name.to_lower().replace(" ", "_")
    plant_avatar.texture = load(_avatar_folder + avatar_name + ".png")
    
    for i in range(wand.spells.size()):
        var spell_name = wand.spells[i]
        if spell_name:
            var inventory_item := (GameManager.inventory_item_dict.get("Spell Inventory").get(spell_name) as PackedScene).instantiate() as InventoryItem
            #inventory_basic_ability.set_item(i, inventory_item)

    level_menu.hide_all_tab()
    level_menu.plant_tab.visible = true
    level_menu.spell_tab.visible = true
