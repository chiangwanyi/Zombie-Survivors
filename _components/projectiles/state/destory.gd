extends State

@onready var cpu_particles_2d: CPUParticles2D = $"../../CPUParticles2D"
@onready var collision_shape_2d: CollisionShape2D = $"../../CollisionShape2D"
@onready var sprite_2d: Sprite2D = $"../../Sprite2D"


func enter() -> void:
    sprite_2d.set_deferred("visible", false)
    collision_shape_2d.set_deferred("disabled", true)
    
func update(_delta: float) -> void:
    if not cpu_particles_2d.emitting:
        owner.queue_free()

func exit() -> void:
    pass
