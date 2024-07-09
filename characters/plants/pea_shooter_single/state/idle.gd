extends State

@onready var head_animated_sprite_2d: AnimatedSprite2D = $"../../HeadAnimatedSprite2D"
@onready var stem_animated_sprite_2d: AnimatedSprite2D = $"../../StemAnimatedSprite2D"
@onready var weapon_aim_point: Marker2D = $"../../WeaponAimPoint"

var body: Plant

func enter() -> void:
    body = owner as Plant
    head_animated_sprite_2d.play("idle")
    stem_animated_sprite_2d.play("default")

func update(_delta: float) -> void:
    var can_attack_zombies : Array[Zombie] = []
    
    # 当前时刻【之前】，该植物没有攻击目标
    if body.target_zombies.is_empty():
        for zombie in GameManager.registerd_zombies.values() as Array[Zombie]:
            # 植物与僵尸的距离
            var distance = zombie.global_position.distance_to(body.global_position)
            # 如果距离在攻击范围内
            if distance < body.attack_detection_radius:
                can_attack_zombies.append(zombie)
                
            # 单发豌豆射手一次只能攻击一个僵尸
            # TODO 攻击策略（优先攻击 血量低/危险性最大/距离最近）
            if not can_attack_zombies.is_empty():
                body.target_zombies.clear()
                var target_zombie = can_attack_zombies.pick_random() as Zombie
                body.target_zombies.append(target_zombie.key)
        
    if not head_animated_sprite_2d.is_playing() and not stem_animated_sprite_2d.is_playing():
        if not body.target_zombies.is_empty():
            emit_signal("finished", "Attack")
        else:
            head_animated_sprite_2d.play("idle")
            stem_animated_sprite_2d.play("default")
    
        
func exit() -> void:
    pass

func _exit_tree() -> void:
    pass

