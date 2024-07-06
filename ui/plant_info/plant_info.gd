extends Panel

@onready var plant_name: Label = $VBoxContainer/HBoxContainer/Name
@onready var plant_cast: Label = $VBoxContainer/HBoxContainer2/Cast
@onready var energe: Label = $VBoxContainer/HBoxContainer3/Energe

@onready var avatar: TextureRect = $Avatar

@onready var inventory_ability: InventoryBasicAbility = $BasicInventoryAbility

var current_plant_key: String

func _ready() -> void:
    visible = false
    inventory_ability.reload()

# 由被点击的【植物】调用
func show_info(plant_key: String) -> void:
    var plant = GameManager.registerd_plants[plant_key] as Plant
    current_plant_key = plant_key
    
    var wand = plant.wand as Wand
    
    plant_name.text = GameManager.cfg_seeds[plant.plant_name].description
    avatar.texture = load("res://_assets/images/plants/%s.png" % plant.plant_name)

    inventory_ability.reload(wand.capacity)
    
    for i in range(wand.spells.size()):
        var spell_name = wand.spells[i]
        if spell_name:
            var spell_item = (load("res://inventory/item/spell/%s_item.tscn" % spell_name.to_lower()) as PackedScene).instantiate()
            inventory_ability.set_item(i, spell_item)
        
    visible = true


func _on_inventory_item_sync() -> void:
    var spell_list: PackedStringArray = []
    for slot in inventory_ability.item_slot_list:
        if slot.get_child_count() > 0:
            var item = slot.get_child(0) as InventoryItem
            spell_list.append(item.item_name)
        else:
            spell_list.append("")
            
    var plant := GameManager.registerd_plants[current_plant_key] as Plant
    plant.wand.spells = spell_list
    plant.wand.reload()
