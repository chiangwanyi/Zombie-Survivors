extends Node2D

@onready var zombie_spawn_1_location: PathFollow2D = $ZombieSpawnPath1/ZombieSpawnLocation


func _ready():
    pass
    #GameManager.current_level = self


func _on_zombie_spawn_timer_1_timeout() -> void:
    zombie_spawn_1_location.progress_ratio = randf()
    GameManager.create_zombie(zombie_spawn_1_location.position, "regular_zombie")
