extends Panel

@onready var inventory: InventoryBasicAbility = $InventoryBasicAbility

func _ready() -> void:
    inventory.reload(-1)
    
    if GameManager.inventory_item_dict.has(inventory.inventory_name):
        var cfg_level := GameManager.cfg_levels.get(GameManager.current_level_name) as Dictionary
        
        var initial_spells = cfg_level.get("initial_spells") as Array
        for i in range(inventory.slot_size):
            if i < initial_spells.size():
                var spell_name = initial_spells[i]
                if spell_name:
                    var item_map := GameManager.inventory_item_dict.get(inventory.inventory_name) as Dictionary
                    var item := (item_map.get(spell_name) as PackedScene).instantiate() as InventoryItem
                    inventory.set_item(i, item)
            else:
                break
