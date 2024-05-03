extends ProjectileWeapon

func _ready() -> void:
	projectile.append(&"Pea")
	spawn_position = global_position
