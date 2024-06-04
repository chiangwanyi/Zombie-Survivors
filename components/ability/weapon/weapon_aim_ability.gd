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
			#print("2", reticle.position)
			# 参考整理的公式
			reticle_position.x = reticle.position.x - 1920 * 0.5 * (1 / 1)
			reticle_position.y = reticle.position.y - 1080 * 0.5 * (1 / 1)
			weapon.look_at(reticle_position)
