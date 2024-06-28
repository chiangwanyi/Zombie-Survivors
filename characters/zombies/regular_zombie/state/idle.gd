extends State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter() -> void:
    animated_sprite_2d.play(["idle1", "idle2"].pick_random())

func update(_delta: float) -> void:
    pass
    
func exit() -> void:
    pass

func _exit_tree() -> void:
    pass

