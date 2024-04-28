extends State

func enter() -> void:
	var head_animation := owner.get_node(^"HeadAnimation") as AnimatedSprite2D
	var stem_animation := owner.get_node(^"StemAnimation") as AnimatedSprite2D
	
	head_animation.play(&"idle")
	stem_animation.play(&"idle")
	super.enter()

func update(_delta: float) -> void:
	var controller := owner.get_node(^"CharacterController") as CharacterController2D
	var input_direction = controller.get_input_direction()
	if not input_direction.is_zero_approx():
		emit_signal(&"finished", &"move")
