extends Node
## 全局游戏管理器，管理整个游戏中的数据、资源


## 游戏配置文件路径
var _cfg_path = "res://config.json"
## 植物场景文件夹
var _scenes_plant_folder = "res://characters/plants/"

## 加载的游戏配置内容，可由其他组件直接读取
var cfg: Dictionary
## 加载的游戏关卡配置内容，Map<String:LevelName, Dict:Level>
var cfg_levels: Dictionary
## 加载的游戏 Seed 配置内容，Map<String:SeedName, Dict:Seed>
var cfg_seeds: Dictionary

## 当前活动 Level 场景名称
var current_level_name: String
## 当前活动 Level 场景
var current_level: Node2D

## 主HUD
var main_hud: CanvasLayer

## 背包 Map<String:InventoryName, Node:Inventory>
var inventories: Dictionary = {}

## 法杖武器 Map<String:SpellName, PackedScene:Spell>
var registed_wand_spells: Dictionary = {}

func _ready() -> void:
    # 读取配置文件
    var cfg_file = FileAccess.open(_cfg_path, FileAccess.READ)
    cfg = JSON.parse_string(cfg_file.get_as_text()) as Dictionary

    # 读取关卡配置
    for level in cfg.get("levels", []):
        cfg_levels[level.get("name")] = level

    for item in cfg.get("seeds", []):
        cfg_seeds[item.get("name")] = item
        
    _register_wand_spells()

## 创建植物
func create_plant(_pos: Vector2, plant_name: String):
    if not current_level:
        return
    var scene_path = _scenes_plant_folder + plant_name.to_lower() + "/" + plant_name.to_lower() + ".tscn"
    var plant = (load(scene_path) as PackedScene).instantiate() as Plant
    plant.position = current_level.get_local_mouse_position()
    current_level.add_child(plant)

func _register_wand_spells():
    registed_wand_spells["Sun"] = load("res://spells/projectile/sun.tscn") as PackedScene

