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
    tab_container.visible = false
    _update_tab_bar()

## 更新 tab_bar 按钮
func _update_tab_bar() -> void:
    for i in range(tab_bar.get_child_count()):
        tab_bar.get_child(i).queue_free()
        
    for item in level_menu_button:
        var button := Button.new()
        button.text = item
        button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        # 监听 TabBar 按钮 按下事件
        button.pressed.connect(_display_tab_container.bind(item))
        tab_bar.add_child(button)


func _display_tab_container(item: String) -> void:
    if item == current_tab:
        if tab_container.visible:
            tab_container.visible = false
        else:
            tab_container.visible = true
    else:
        # 隐藏 tab_container 下的所有 child
        hide_all_tab()
        
        current_tab = item
        tab_container.visible = true

        match item:
            "种植" : display_seeds_tab()
            "配方" : display_plant_tab()
            "背包" : display_spell_tab()

func hide_all_tab() -> void:
    for i in range(tab_container.get_child_count()):
        tab_container.get_child(i).visible = false

func display_seeds_tab() -> void:
    seeds_tab.visible = true

func display_plant_tab() -> void:
    plant_tab.visible = true  

func display_spell_tab() -> void:
    spell_tab.visible = true
