class_name ProjectileWeapon extends Weapon

var projectile : Array[StringName] = []
var spawn_position: Vector2
var projectiles_per_shot := 1

func weapon_use(direction: Vector2) -> void :
	print("Weapon use")
	super.weapon_use(direction)
	
	for i in range(projectiles_per_shot):
		spawn_projectile(i, projectiles_per_shot, direction)
		
func spawn_projectile(index: int, total: int, direction: Vector2) -> void :
	if GameManager.projectile_scenes.has(projectile[index]):
		var scene := GameManager.projectile_scenes.get(projectile[index]) as PackedScene
		var projectile := scene.instantiate() as Projectile
		projectile.direction = direction
		projectile.position = GameManager.level.to_local(spawn_position)
		
		GameManager.level.add_child(projectile)
		
