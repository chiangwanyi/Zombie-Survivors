extends State

@onready var animation: AnimatedSprite2D = $"../../AnimatedSprite2D"

func _ready() -> void:
    pass

func enter() -> void:
    animation.play("idle")
    ($"../../SpawnTimer" as Timer).start()
    super.enter()

func update(_delta: float) -> void:
    pass

func exit() -> void:
    pass

func _exit_tree() -> void:
    pass

func _on_spawn_timer_timeout() -> void:
    if not is_active():
        return
    emit_signal("finished", "Attack")
