class_name HandleWeaponAbility extends CharacterAbility

## 初始化携带的武器scene
@export var initial_weapon_scene: PackedScene
## 武器挂载位置
@export var weapon_attachment: Marker2D
## 是否自动使用武器
@export var auto_use: bool = false
#@export var projectile_spawn: Marker2D

## 当前持有的武器
var current_weapon: Weapon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if initial_weapon_scene:
		var weapon = initial_weapon_scene.instantiate() as Weapon
		weapon.position = weapon_attachment.position
		current_weapon = weapon
		owner.add_child.call_deferred(weapon)

func shoot_start() -> void:
	if not current_weapon:
		return
	
	current_weapon.weapon_input_start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass