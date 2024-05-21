extends Node

const game_level_grass_walk_scene := preload("res://levels/game_grass_walk/game_grass_walk.tscn") as PackedScene

func _ready() -> void:
	go_to_game_level()

func go_to_game_level():
	var game_level := change_scene_to_file(game_level_grass_walk_scene) as Node2D
	GameManager.current_level = game_level

func change_scene_to_file(resource : Resource) -> Node:
	var node = resource.instantiate()

	for child in get_children():
		remove_child(child)
		child.queue_free()
	add_child(node)
	
	return node
