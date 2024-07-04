extends Panel

@onready var inventory: InventoryBasicAbility = $InventoryBasicAbility

func _ready() -> void:
    inventory.reload(-1)
