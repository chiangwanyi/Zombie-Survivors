extends Node

var cfg: Dictionary
var level: Array[Dictionary]

## Scene
const scene_seed_packet := preload("res://Scenes/Entities/SeedPacket/SeedPacket.tscn") as PackedScene


## 当前存活的植物
var plants: Array[Plant] = []
## 当前存活的僵尸
var zombies: Array[Zombie] = []
## 当前游戏场景
var current_level: Node2D

## 所有 Seed 的Dict, key为seed_name, value为Dict
var cfg_seeds: Dictionary = {}
## 已经解锁的 SeedName
var cfg_unlocked_seeds_name: Array[StringName]


## 注册的【投射物 Scene】
var projectile_scenes : Dictionary = {}


## 当前Level选择的 Seed
var selected_seeds: Array[StringName]

func _ready() -> void:
	_load_cfg()
	
	_load_cfg_seeds()
	_load_cfg_unlocked_seeds_name()


func _load_cfg() -> void:
	var cfg_file := FileAccess.open("res://cfg.json", FileAccess.READ)
	cfg = JSON.parse_string(cfg_file.get_as_text())


func _load_level() -> void:
	var level_fiel := FileAccess.open("res://level.json", FileAccess.READ)
	level = JSON.parse_string(level_fiel.get_as_text())	


func _load_cfg_seeds() -> void:
	cfg_seeds.clear()
	for item in cfg.get("seeds", []):
		cfg_seeds[item.get("name")] = item

func _load_cfg_unlocked_seeds_name() -> void:
	cfg_unlocked_seeds_name.clear()
	for item in cfg.get("unlocked_seeds_name", []):
		cfg_unlocked_seeds_name.append(item)
