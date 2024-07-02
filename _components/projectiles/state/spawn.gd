extends State

@onready var sprite_2d: Sprite2D = $"../../Sprite2D"

func enter() -> void:
    print("projectile spawn...")
    if sprite_2d.texture:
        sprite_2d.visible = true
    emit_signal("finished", "Launch")

func exit() -> void:
    pass
