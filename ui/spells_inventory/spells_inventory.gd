extends Panel

@onready var inventory_basic_ability: InventoryBasicAbility = $InventoryBasicAbility

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    inventory_basic_ability.reload(-1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
