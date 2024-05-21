class_name Character2D extends Node

enum CharacterTypes { Player, AI }

@export var character_type: CharacterTypes = CharacterTypes.AI
@export var character_body: Node2D
