extends Node

var plants : Array[Plant] = []
var projectile_scenes : Dictionary = {}
var level : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	projectile_scenes[&"Pea"] = preload("res://entities/projectiles/projectile_pea.tscn") as PackedScene
	print("Game Manager 初始化完成")
