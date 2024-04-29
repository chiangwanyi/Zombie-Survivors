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
				body.target_plant.killed.connect(Callable(body, "on_target_plant_died"))
				print("僵尸:[%s] 追逐 植物:[%s]" % [body, plant])
				break
	else:
		emit_signal("finished", "move")
	#var controller := owner.get_node(^"CharacterController") as CharacterController2D
	#var input_direction = controller.get_input_direction()
	#if not input_direction.is_zero_approx():
		#emit_signal(&"finished", &"move")
