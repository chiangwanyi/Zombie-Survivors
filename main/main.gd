extends Node

const game_level_grass_walk_scene := preload("res://levels/game_grass_walk/game_grass_walk.tscn") as PackedScene
const test_level := preload("res://levels/test/test_level.tscn") as PackedScene


func _ready() -> void:
	go_to_game_level()

func go_to_game_level():
	GameManager.current_level_name = "Level 1"
	var _game_level := change_scene_to_file(test_level) as Node2D

func change_scene_to_file(resource : Resource) -> Node:
	var node = resource.instantiate()

	for child in get_children():
		remove_child(child)
		child.queue_free()
	add_child(node)
	
	return node
