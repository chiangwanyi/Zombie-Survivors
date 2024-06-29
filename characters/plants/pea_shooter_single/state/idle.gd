extends State

@onready var head_animated_sprite_2d: AnimatedSprite2D = $"../../HeadAnimatedSprite2D"
@onready var stem_animated_sprite_2d: AnimatedSprite2D = $"../../StemAnimatedSprite2D"

var body: Plant

func enter() -> void:
    body = owner as Plant
    head_animated_sprite_2d.play("idle")
    stem_animated_sprite_2d.play("default")

func update(_delta: float) -> void:
    if body.target_zombies.is_empty():
        body.wand.attack_range
    
func exit() -> void:
    pass

func _exit_tree() -> void:
    pass

