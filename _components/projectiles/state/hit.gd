extends State

@onready var cpu_particles_2d: CPUParticles2D = $"../../CPUParticles2D"

var body: Projectile2D

func enter() -> void:
    body = owner as Projectile2D
    cpu_particles_2d.emitting = true

func physics_update(_delta: float) -> void:
    emit_signal("finished", "Launch")
    
func exit() -> void:
    pass
