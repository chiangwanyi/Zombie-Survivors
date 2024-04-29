extends State

var head_animation: AnimatedSprite2D
var stem_animation: AnimatedSprite2D
var body : Plant

var need_exit := false

func enter():
	head_animation = owner.get_node(^"HeadAnimation") as AnimatedSprite2D
	stem_animation = owner.get_node(^"StemAnimation") as AnimatedSprite2D
	body = owner as Plant
	
	head_animation.play(&"shoot")
	stem_animation.play(&"shoot")
	
	print("植物 attack 进入")
	super.enter()

func update(_delta: float) -> void:
	if not head_animation.is_playing() and not need_exit:
		head_animation.play()

	if not stem_animation.is_playing() and not need_exit:
		stem_animation.play()
	
	if body.target_zombie != null:
		if (body.target_zombie.position - body.position).x < 0:
			head_animation.flip_h = true
			stem_animation.flip_h = true
		else:
			head_animation.flip_h = false
			stem_animation.flip_h = false
	else:
		emit_signal("finished", "idle")
	
func exit(wait_for_animation_finish : bool) -> void:
	if not wait_for_animation_finish:
		print("等待植物动画结束")
		need_exit = true
		await head_animation.animation_finished
		await stem_animation.animation_finished
	print('植物 attack 退出')
