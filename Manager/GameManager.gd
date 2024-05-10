extends Node

var cfg: Dictionary

## Scene
const scene_seed_packet := preload("res://Scenes/Entities/SeedPacket/SeedPacket.tscn") as PackedScene


## 当前存活的植物
var plants: Array[Plant] = []
## 当前存活的僵尸
var zombies: Array[Zombie] = []
## 当前游戏场景
var current_level: Node2D

## SeedChooser的Seed容量
var cfg_seed_chooser_size: int
## 已经解锁的Seed
var cfg_unlocked_seed_packets_name: Array[StringName]
## SeedBank 的最大Seed数
var cfg_max_seed_bank_size: int
## 所有植物的Dict, key为seed_name, value为Dict
var cfg_plants_dict: Dictionary = {}


## 注册的【投射物 Scene】
var projectile_scenes : Dictionary = {}


## 当前Level选择的 Seed
var selected_seeds: Array[StringName]

func _ready() -> void:
	_load_cfg()
	
	_load_cfg_seed_chooser_size()
	_load_cfg_unlocked_seed_packets_name()
	_load_cfg_plants_dict()

func _load_cfg() -> void:
	var cfg_file := FileAccess.open("res://cfg.json", FileAccess.READ)
	cfg = JSON.parse_string(cfg_file.get_as_text())

func _load_cfg_seed_chooser_size() -> void:
	cfg_seed_chooser_size = int(cfg.get("seed_chooser_size"))

func _load_cfg_unlocked_seed_packets_name() -> void:
	cfg_unlocked_seed_packets_name.clear()
	for item in cfg.get("unlocked_seed_packets", []):
		cfg_unlocked_seed_packets_name.append(item)

func _load_cfg_max_seed_bank_size() -> void:
	cfg_max_seed_bank_size = int(cfg.get("max_seed_bank_size"))

func _load_cfg_plants_dict() -> void:
	cfg_plants_dict.clear()
	for plant in cfg.get("plants", []):
		cfg_plants_dict[plant.get("name")] = plant
