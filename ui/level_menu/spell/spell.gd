extends HBoxContainer

@onready var inventory_basic_ability: InventoryBasicAbility = $InventoryBasicAbility
@onready var tab_bar: TabBar = $VBoxContainer/TabBar


func _ready() -> void:
    inventory_basic_ability.reload()


func _on_tab_bar_tab_changed(tab: int) -> void:
    print(tab)
