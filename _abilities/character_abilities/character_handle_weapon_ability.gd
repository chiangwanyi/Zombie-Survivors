class_name CharacterHandleWeaponAbility extends CharacterAbility

## 初始化携带的武器scene
@export var initial_weapon_scene: PackedScene
## 武器挂载位置
@export var weapon_attachment: Marker2D
## 当前持有的武器
@export var current_weapon: Weapon

func _ready() -> void:
    if not available:
        return
    if initial_weapon_scene:
        current_weapon = initial_weapon_scene.instantiate() as Weapon
    if current_weapon:
        current_weapon.position = weapon_attachment.position
        current_weapon.weapon_owner = $".." as Node2D
    if initial_weapon_scene:
        owner.add_child.call_deferred(current_weapon)

func shoot_start() -> void:
    if not current_weapon:
        return
    print("weapon %s shoot start" % current_weapon.name)
    current_weapon.turn_on()
    
func shoot_stop() -> void:
    if not current_weapon:
        return
    print("weapon %s shoot stop" % current_weapon.name)
    current_weapon.turn_off()    
