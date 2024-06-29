extends State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

var body: Zombie

func enter() -> void:
    body = owner as Zombie
    animated_sprite_2d.play(["idle1", "idle2"].pick_random())

func update(_delta: float) -> void:
    var min_distance : float
    var target_plant : Plant

    # 僵尸在 Idle 状态时会自动寻找 Plant，无视距离
    for plant in GameManager.registerd_plants.values():
        var distance = body.global_position.distance_to(plant.global_position)
        if target_plant:
            if min_distance > distance:
                min_distance = distance
                target_plant = plant
        else:
            min_distance = distance
            target_plant = plant

    if target_plant:
        print("target_plant: ", target_plant)
        body.target_plant = target_plant
        emit_signal("finished", "Walk")
    #else:
        #print("no target_plant")

    
func exit() -> void:
    pass

func _exit_tree() -> void:
    pass

