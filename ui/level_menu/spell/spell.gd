extends HBoxContainer

@onready var inventory_basic_ability: InventoryBasicAbility = $InventoryBasicAbility

func _ready() -> void:
    inventory_basic_ability.reload()
