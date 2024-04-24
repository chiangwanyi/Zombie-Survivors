extends State

var idle_animations := [&"idle1", &"idle2"]

func enter() -> void:
	var animation := owner.get_node(^"AnimatedSprite2D") as AnimatedSprite2D
	
	animation.play(idle_animations.pick_random())
	super.enter()

func update(_delta: float) -> void:
	var controller := owner.get_node(^"CharacterController") as CharacterController2D
	var input_direction = controller.get_input_direction()
	if not input_direction.is_zero_approx():
		emit_signal(&"finished", &"move")
