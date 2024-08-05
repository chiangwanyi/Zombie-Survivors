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
var current_level: GameLevel

## 主HUD
var main_hud: CanvasLayer

## 背包 Map<String:InventoryName, Node:InventoryBasicAbility>
var inventories: Dictionary = {}

## 背包 Map<String:InventoryType, Dictionary:Map<String:ItemName, PackedScene:InventoryItem>>
var inventory_item_dict: Dictionary = {}

## 法杖武器 Spell Map<String:SpellName, PackedScene:Spell>
var registed_spells: Dictionary = {}

## 当前存活的植物 Map<String:Key, Plant:植物>
var registerd_plants: Dictionary

## 当前存活的僵尸 Map<String:Key, Zombie:僵尸>
var registerd_zombies: Dictionary

func _ready() -> void:
    # 读取配置文件
    var cfg_file = FileAccess.open(_cfg_path, FileAccess.READ)
    cfg = JSON.parse_string(cfg_file.get_as_text()) as Dictionary

    # 读取关卡配置
    for level in cfg.get("levels", []):
        cfg_levels[level.get("name")] = level

    for item in cfg.get("seeds", []):
        cfg_seeds[item.get("name")] = item
    
    _register_inventory_items()

    _register_spells()

## 创建植物
func create_plant(_pos: Vector2, plant_name: String) -> void:
    if not is_instance_valid(current_level):
        return
    var scene_path = _scenes_plant_folder + plant_name.to_lower().replace(" ", "_") + "/" + plant_name.to_lower().replace(" ", "_") + ".tscn"
    var plant = (load(scene_path) as PackedScene).instantiate() as Plant

    plant.position = current_level.level.get_local_mouse_position()
    plant.key = IdUtils.unique_key()
    plant.plant_name = plant_name

    current_level.level.call_deferred("add_child", plant)
    registerd_plants[plant.key] = plant

## 创建僵尸
func create_zombie(pos: Vector2, zombie_name: String) -> void:
    if not is_instance_valid(current_level):
        return
        
    if registerd_zombies.size() > 1:
        return
        
    var scene_path = "res://characters/zombies/" + zombie_name.to_lower() + "/" + zombie_name.to_lower() + ".tscn"
    var zombie = (load(scene_path) as PackedScene).instantiate() as Zombie

    zombie.position = pos
    zombie.key = IdUtils.unique_key()
    zombie.zombie_name = zombie_name

    current_level.level.call_deferred("add_child", zombie)
    registerd_zombies[zombie.key] = zombie
    current_level.modify_zombie_count(1)

func remove_zombie(key: String) -> void:
    get_tree().call_group("plant", "remove_target_zombie", key)
    var zombie = registerd_zombies[key] as Zombie
    registerd_zombies.erase(key)
    zombie.queue_free()
    current_level.modify_zombie_count(-1)

func _register_spells() -> void:
    for spell in cfg.get("spells", []):
        registed_spells[spell.get("name")] = load(spell.get("scene")) as PackedScene

func _register_inventory_items() -> void:
    for value in cfg.get("inventories", []):
        var item_name = value.get("item_name")
        var item_inventory_type = value.get("item_inventory_type")
        var item_scene = load(value.get("item_scene")) as PackedScene

        if not inventory_item_dict.has(item_inventory_type):
            inventory_item_dict[item_inventory_type] = {}
        inventory_item_dict[item_inventory_type][item_name] = item_scene
