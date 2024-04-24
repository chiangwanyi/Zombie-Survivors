extends State

func enter() -> void:
	print("idle")
	var head_animation := owner.get_node(^"HeadAnimation") as AnimatedSprite2D
	var stem_animation := owner.get_node(^"StemAnimation") as AnimatedSprite2D
	
	head_animation.play(&"idle")
	stem_animation.play(&"idle")
	super.enter()
