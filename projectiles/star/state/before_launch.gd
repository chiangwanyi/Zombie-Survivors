extends State

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter() -> void:
    animation_player.play("spin")
    emit_signal("Launch")

