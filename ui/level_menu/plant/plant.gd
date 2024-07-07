extends HBoxContainer

@onready var inventory_basic_ability: InventoryBasicAbility = $InventoryBasicAbility
@onready var level_menu: LevelMenu = $"../.."

@onready var plant_title_label: Label = $InfoPanel/Panel/HBoxContainer/Title


var current_plant_key: String

func _ready() -> void:
    pass
    
func show_plant_info(plant_key: String) -> void:
    var plant = GameManager.registerd_plants[plant_key] as Plant
    current_plant_key = plant_key
    
    var wand = plant.wand as Wand

    plant_title_label.text = GameManager.cfg_seeds[plant.plant_name].title

    level_menu.hide_all_tab()
    level_menu.display_plant_tab()
    level_menu.display_spell_tab()
    level_menu.visible = true
