extends State

@onready var animation: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var spawn_timer: Timer = $"../../SpawnTimer"

func enter() -> void:
    spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
    if not is_active():
        return
    #emit_signal("finished", "Attack")
