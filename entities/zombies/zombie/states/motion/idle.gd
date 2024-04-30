extends State

var idle_animations := [&"idle1", &"idle2"]
var body : Zombie
var animation : AnimatedSprite2D

func enter() -> void:
	body = owner as Zombie
	animation = owner.get_node(^"AnimatedSprite2D") as AnimatedSprite2D
	
	animation.play(idle_animations.pick_random())
	super.enter()

func update(_delta: float) -> void:
	if body.target_plant == null:
		for plant in GameManager.plants:
			if plant != null:
				body.target_plant = plant
				print("僵尸:[%s] 追逐 植物:[%s]" % [body, plant])
				break
	else:
		emit_signal("finished", "move")
