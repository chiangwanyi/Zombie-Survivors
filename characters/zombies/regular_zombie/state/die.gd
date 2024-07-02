extends State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var body_collision_shape_2d: CollisionShape2D = $"../../CollisionShape2D"
@onready var attack_zone_collision_shape_2d: CollisionShape2D = $"../../AttackZone/CollisionShape2D"

var body: Zombie

func enter() -> void:
    body = owner as Zombie
    body_collision_shape_2d.set_deferred("disabled", true)
    attack_zone_collision_shape_2d.set_deferred("disabled", true)
    animated_sprite_2d.play(["die1", "die2"].pick_random())
    GameManager.remove_zombie(body.key)

func update(_delta: float) -> void:
    pass
    
func exit() -> void:
    pass

func _exit_tree() -> void:
    pass

