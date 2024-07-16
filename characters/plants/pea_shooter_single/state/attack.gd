extends State

@onready var head_animated_sprite_2d: AnimatedSprite2D = $"../../HeadAnimatedSprite2D"
@onready var stem_animated_sprite_2d: AnimatedSprite2D = $"../../StemAnimatedSprite2D"
@onready var weapon_aim_point: Marker2D = $"../../WeaponAimPoint"
@onready var handle_weapon_ability: CharacterHandleWeaponAbility = $"../../HandleWeaponAbility"


var body: Plant
var current

func enter() -> void:
    body = owner as Plant
    head_animated_sprite_2d.play("attack")
    stem_animated_sprite_2d.play("default")

func update(_delta: float) -> void:
    ## 豌豆射手在攻击帧时选择攻击对象，然后射击
    #if head_animated_sprite_2d.frame == 12:
        #if not body.target_zombies.is_empty():
            #var key = body.target_zombies.pick_random()
            #weapon_aim_point.global_position = GameManager.registerd_zombies[key].global_position
        #handle_weapon_ability.shoot_start()
    #
    if not head_animated_sprite_2d.is_playing() and not stem_animated_sprite_2d.is_playing():
        if body.target_zombies.is_empty():
            emit_signal("finished", "Idle")
        else:
            head_animated_sprite_2d.play("attack")
            stem_animated_sprite_2d.play("default")
    
func exit() -> void:
    pass

func _exit_tree() -> void:
    pass

