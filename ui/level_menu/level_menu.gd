class_name LevelMenu extends VBoxContainer

@export var level_menu_button: Array[String] = ["种植", "配方", "背包", "商店", "设置"]
@onready var tab_bar: HBoxContainer = $TabBar
@onready var tab_container: VBoxContainer = $TabContainer

@onready var seeds_tab: HBoxContainer = $TabContainer/Seeds
@onready var plant_tab: HBoxContainer = $TabContainer/Plant
@onready var spell_tab: HBoxContainer = $TabContainer/Spell

## 当前选项
var current_tab: String

func _ready() -> void:
    _update_tab_bar()

## 更新 tab_bar 按钮
func _update_tab_bar() -> void:
    for i in range(tab_bar.get_child_count()):
        tab_bar.get_child(i).queue_free()
    
    for i in range(level_menu_button.size()):
        tab_bar.add_theme_constant_override("separator_width", 0)
        var button := Button.new()
        button.text = level_menu_button[i]
        button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        # 监听 TabBar 按钮 按下事件
        button.pressed.connect(_display_tab_container.bind(level_menu_button[i], i))
        tab_bar.add_child(button)

func _display_tab_container(item: String, index: int) -> void:
    for i in range(tab_container.get_child_count()):
        if i != index:
            tab_container.get_child(i).visible = false

    match item:
        "种植":
            if seeds_tab.visible:
                seeds_tab.visible = false
            else:
                seeds_tab.visible = true
        "配方":
            if plant_tab.visible:
                plant_tab.visible = false
            else:
                plant_tab.visible = true
        "背包":
            if spell_tab.visible:
                spell_tab.visible = false
            else:
                spell_tab.visible = true
                
    current_tab = item

func hide_all_tab() -> void:
    for i in range(tab_container.get_child_count()):
        tab_container.get_child(i).visible = false
    current_tab = ""
