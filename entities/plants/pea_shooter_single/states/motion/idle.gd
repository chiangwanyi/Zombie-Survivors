extends State

var head_animation: AnimatedSprite2D
var stem_animation: AnimatedSprite2D

var need_exit := false

func enter() -> void:
	head_animation = owner.get_node(^"HeadAnimation") as AnimatedSprite2D
	stem_animation = owner.get_node(^"StemAnimation") as AnimatedSprite2D
	
	head_animation.play(&"idle")
	stem_animation.play(&"idle")
	super.enter()

func update(_delta: float) -> void:
	if not head_animation.is_playing() and not need_exit:
		head_animation.play()

	if not stem_animation.is_playing() and not need_exit:
		stem_animation.play()
		
func exit(wait_for_animation_finish : bool) -> void:
	if not wait_for_animation_finish:
		need_exit = true
		await head_animation.animation_finished
		await stem_animation.animation_finished
		print('植物 idle 退出')
