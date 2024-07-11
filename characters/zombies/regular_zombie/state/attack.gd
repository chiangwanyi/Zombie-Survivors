extends State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var sfx_zombie_attack: AudioStreamPlayer = $"../../SfxZombieAttack"

var body: Zombie

func enter() -> void:
    body = owner as Zombie
    animated_sprite_2d.play("attack")

func update(_delta: float) -> void:
    if animated_sprite_2d.frame % 25 == 0:
        sfx_zombie_attack.play()
