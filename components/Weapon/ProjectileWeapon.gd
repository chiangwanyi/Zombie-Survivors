class_name ProjectileWeapon extends Weapon

## 【投射物武器】可以发射的【投射物】
var projectile : Array[StringName] = []
var spawn_position: Vector2
var projectiles_per_shot := 1

func weapon_use(direction: Vector2) -> void :
	print("Weapon use")
	super.weapon_use(direction)
	
	for i in range(projectiles_per_shot):
		_spawn_projectile(i, projectiles_per_shot, direction)
		
func _spawn_projectile(index: int, total: int, direction: Vector2) -> void :
	if GameManager.projectile_scenes.has(projectile[index]):
		var scene := GameManager.projectile_scenes.get(projectile[index]) as PackedScene
		var p := scene.instantiate() as Projectile
		p.direction = direction
		#p.position = GameManager.level.to_local(spawn_position)
		#
		#GameManager.level.add_child(p)
		
