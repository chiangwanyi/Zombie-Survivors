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
var weapon: Weapon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if owner is Weapon:
		weapon = owner
		
	# 加载准星，并挂载到主HUD上
	if reticle_type == ReticleTypes.UI:
		if reticle_scene:
			reticle = reticle_scene.instantiate() as Control
			GameManager.main_hud.call_deferred("add_child", reticle)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if weapon:
		if reticle_type == ReticleTypes.UI and aim_control == AimControls.Mouse and reticle:
			# 准星在 HUD 的位置
			var tmp_p = reticle.position
			# 参考整理的公式
			tmp_p.x = tmp_p.x - 1920 * 0.5 * (1 / 1)
			tmp_p.y = tmp_p.y - 1080 * 0.5 * (1 / 1)
			#print(weapon.projectile_spawn.global_position)
			weapon.look_at(tmp_p)
