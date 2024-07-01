extends State

@onready var head_animated_sprite_2d: AnimatedSprite2D = $"../../HeadAnimatedSprite2D"
@onready var stem_animated_sprite_2d: AnimatedSprite2D = $"../../StemAnimatedSprite2D"
@onready var weapon_aim_point: Marker2D = $"../../WeaponAimPoint"
@onready var handle_weapon_ability: CharacterHandleWeaponAbility = $"../../HandleWeaponAbility"


var body: Plant
var target_zombie: Zombie

func enter() -> void:
    body = owner as Plant
    head_animated_sprite_2d.play("attack")
    stem_animated_sprite_2d.play("default")
    target_zombie = body.target_zombies.pick_random()

func update(_delta: float) -> void:
    if head_animated_sprite_2d.frame == 12:
        handle_weapon_ability.shoot_start()
        
    if target_zombie:
        weapon_aim_point.global_position = target_zombie.global_position
    
    if not head_animated_sprite_2d.is_playing() and not stem_animated_sprite_2d.is_playing():
        head_animated_sprite_2d.play("attack")
        stem_animated_sprite_2d.play("default")
    
func exit() -> void:
    pass

func _exit_tree() -> void:
    pass

