class_name ProjectileWeapon extends Weapon

var projectile : Array[StringName] = []
var spawn_posistion: Vector2
var projectiles_per_shot := 1

func weapon_use() -> void :
	print("Weapon use")
	super.weapon_use()
	
	for i in range(projectiles_per_shot):
		spawn_projectile(i, projectiles_per_shot)
		
func spawn_projectile(index: int, total: int) -> void :
	if GameManager.projectile_scenes.has(projectile[index]):
		var scene := GameManager.projectile_scenes.get(projectile[index]) as PackedScene
		var projectile := scene.instantiate() as Projectile
		
		projectile.position = spawn_posistion
		owner.add_child(projectile)
		
