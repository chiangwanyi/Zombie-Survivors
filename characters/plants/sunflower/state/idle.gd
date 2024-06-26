extends State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

#@onready var animation: AnimatedSprite2D = $"../../AnimatedSprite2D"
#@onready var spawn_timer: Timer = $"../../SpawnTimer"

func enter() -> void:
    animated_sprite_2d.play("idle")
    #spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
    if not is_active():
        return
    #emit_signal("finished", "Attack")
