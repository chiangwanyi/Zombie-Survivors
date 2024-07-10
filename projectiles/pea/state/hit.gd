extends State

@onready var cpu_particles_2d: CPUParticles2D = $"../../CPUParticles2D"

var body: Projectile2D

func enter() -> void:
    body = owner as Projectile2D
    cpu_particles_2d.emitting = true
    
func physics_update(_delta: float) -> void:
    var valid_body: Array[Area2D] = []
    
    for damage_body in body.waiting_damage_area_list:
        if is_instance_valid(damage_body):
            valid_body.append(damage_body)
            
    body.damage_on_touch_ability.damage(valid_body)

