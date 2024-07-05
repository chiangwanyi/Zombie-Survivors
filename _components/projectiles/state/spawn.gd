extends State

@onready var sprite_2d: Sprite2D = $"../../Sprite2D"

func enter() -> void:
    pass
    
func update(_delta: float) -> void:
    emit_signal("finished", "Launch")

func exit() -> void:
    pass
