extends Control

@onready var level: Node2D = $Level

func _ready() -> void:
    GameManager.current_level = level
