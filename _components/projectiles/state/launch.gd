extends State

var body: Projectile2D
var timestep : float
var velocity : Vector2

var linera_direction: Vector2

func enter() -> void:
    body = owner as Projectile2D
    timestep = 0.02
    velocity = body.body_force * body.get_forward_direction()
    linera_direction = body.get_forward_direction().normalized()

   
func physics_update(delta: float) -> void:
    if body.trajectory == Projectile2D.ProjectileTrajectory.GRAVITY_AFFECTED:
        velocity.y += body.body_gravity * timestep
        body.position = body.position + velocity * timestep
        velocity = velocity * clampf(1.0 - body.body_drag * timestep, 0.0, 1.0)
    elif body.trajectory == Projectile2D.ProjectileTrajectory.LINEAR:
        body.position += (linera_direction * body.body_force * delta)


func _on_pea_area_entered(area: Area2D) -> void:
    body.hited_body = area
    #cpu_particles_2d.emitting = true
