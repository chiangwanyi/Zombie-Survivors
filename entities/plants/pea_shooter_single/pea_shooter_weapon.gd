extends ProjectileWeapon

func _ready() -> void:
	projectile.append(&"Pea")
	spawn_posistion = position
