class_name WeaponAimAbility extends WeaponAbility

enum AimControls { 
    Off, 
    PrimaryMovement,
    Mouse, 
    CharacterRotateCameraDirection
}

enum ReticleTypes { 
    None, 
    Scene, 
    UI
}

@export var aim_control: AimControls = AimControls.Mouse
@export var reticle_type: ReticleTypes = ReticleTypes.UI
@export var reticle_scene: PackedScene

var reticle: Control
var reticle_position: Vector2

var weapon: Weapon

func _ready() -> void:
    if not available:
        return
    if owner is Weapon:
        weapon = owner
        
    # 加载准星，并挂载到主HUD上
    if reticle_type == ReticleTypes.UI:
        if reticle_scene:
            reticle = reticle_scene.instantiate() as Control
            GameManager.main_hud.call_deferred("add_child", reticle)

func _physics_process(delta: float) -> void:
    if not available:
        return
    if weapon:
        if reticle_type == ReticleTypes.UI and aim_control == AimControls.Mouse and reticle:
            weapon.look_at(weapon.get_global_mouse_position())
                
