@icon("res://components/character_controller/character_controller_2d.svg")
class_name CharacterController2D extends Node

enum FacingDirections { West, East, North, South }

enum CharacterTypes { Player, NPC }

# 角色类型
@export var character_type := CharacterTypes.NPC

@export var max_walk_speed: float = 450
@export var max_run_speed: float = 700

var speed = 0.0
var velocity = Vector2()

func get_input_direction() -> Vector2:
	if character_type == CharacterTypes.NPC:
		return Vector2.ZERO
	var input_direction = Vector2(
			Input.get_axis(&"move_left", &"move_right"),
			Input.get_axis(&"move_up", &"move_down")
	)
	return input_direction
