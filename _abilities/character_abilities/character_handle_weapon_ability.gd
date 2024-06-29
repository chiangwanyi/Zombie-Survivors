class_name CharacterHandleWeaponAbility extends CharacterAbility

@onready var auto_use_timer: Timer = $AutoUseTimer

## 初始化携带的武器scene
@export var initial_weapon_scene: PackedScene
## 武器挂载位置
@export var weapon_attachment: Marker2D
## 当前持有的武器
@export var current_weapon: Weapon

## 是否自动使用武器
@export var auto_use: bool = false:
    set(value):
        if not is_inside_tree():
            await ready
        auto_use = value
        auto_use_timer.one_shot = not value
        if value and auto_use_timer.is_stopped():
            auto_use_timer.start()

func _ready() -> void:
    if not available:
        return
    if initial_weapon_scene:
        current_weapon = initial_weapon_scene.instantiate() as Weapon
    if current_weapon:
        current_weapon.position = weapon_attachment.position
        current_weapon.weapon_owner = $".." as Node2D
    #if auto_use:
        #current_weapon.trigger_pressed = true
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


func _on_auto_use_timer_timeout() -> void:
    if not current_weapon:
        return
    current_weapon.turn_on()        
