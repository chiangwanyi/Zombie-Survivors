extends State

@onready var head_animated_sprite_2d: AnimatedSprite2D = $"../../HeadAnimatedSprite2D"
@onready var stem_animated_sprite_2d: AnimatedSprite2D = $"../../StemAnimatedSprite2D"

var body: Plant

func enter() -> void:
    body = owner as Plant
    head_animated_sprite_2d.play("idle")
    stem_animated_sprite_2d.play("default")

func update(_delta: float) -> void:
    var can_attack_zombies : Array[Zombie] = []
    
    if body.target_zombies.is_empty():
        for zombie in GameManager.registerd_zombies.values() as Array[Zombie]:
            var distance = zombie.global_position.distance_to(body.global_position)
            if distance < body.wand.attack_range:
                can_attack_zombies.append(zombie)
    else:
        # 单发豌豆射手一次只能攻击一个僵尸
        # TODO 攻击策略（优先攻击 血量低/危险性最大/距离最近）
        pass
        
func exit() -> void:
    pass

func _exit_tree() -> void:
    pass

