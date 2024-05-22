class_name ProjectileWeapon extends Weapon

## 【投射物武器】可以发射的【投射物】
@export var projectiles: Array[PackedScene] = []
## 每次发射的【投射物】数量
@export var projectiles_per_shot := 1

func weapon_use(direction: Vector2) -> void :
	print("Weapon use")
	super.weapon_use(direction)
	
	for i in range(projectiles_per_shot):
		_spawn_projectile(i, projectiles_per_shot, direction)
		
func _spawn_projectile(index: int, total: int, direction: Vector2) -> void:
	pass
	#if GameManager.projectile_scenes.has(projectile[index]):
		#var scene := GameManager.projectile_scenes.get(projectile[index]) as PackedScene
		#var p := scene.instantiate() as Projectile
		#p.direction = direction
		#p.position = GameManagerlevel_jsonl.to_local(spawn_position)
		#
		#GameManagerlevel_jsonl.add_child(p)
		