extends State

var body: Projectile2D
var timestep : float
var velocity : Vector2

func enter() -> void:
    body = owner as Projectile2D
    timestep = 0.02
    velocity = 500 * body.get_forward_direction()
    print("projectile launch...")

   
func physics_update(_delta: float) -> void:
    if body.trajectory == Projectile2D.ProjectileTrajectory.GRAVITY_AFFECTED:
        velocity.y += body.body_gravity * timestep
        body.position = body.position + velocity * timestep
        velocity = velocity * clampf(1.0 - body.body_drag * timestep, 0.0, 1.0)

